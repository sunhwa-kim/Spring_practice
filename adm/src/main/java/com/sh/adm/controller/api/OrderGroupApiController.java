package com.sh.adm.controller.api;

import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderDetailListApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderDetailListApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.service.OrderGroupApiLogicService;
import com.sh.adm.service.ordergroup.OrderGroupViewService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.MediaTypes;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

import java.net.URI;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;


@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/cart")
public class OrderGroupApiController{

    private final OrderGroupViewService orderGroupViewService;
    private final OrderGroupApiLogicService orderGroupApiLogicService;

    @PostMapping("")
    @ResponseStatus(HttpStatus.CREATED)
    public Header<OrderDetailApiResponse> cart(@RequestBody @Valid Header<OrderDetailApiRequest> request) {
        /**
         *   장바구니 담기 버튼 -> ItemId [ OrderGroupId-> OrderDetail ]
         */
        return orderGroupApiLogicService.addToOrderDetail(request);
    }

    @PutMapping("")
    public Header<OrderDetailListApiResponse> updateCart(@RequestBody Header<OrderDetailListApiRequest> request) {
        request.getData().getItems().stream().forEach(orderItem -> {
            log.info("id >> {}",orderItem.getItem_id());
            log.info("quantity >> {}",orderItem.getQuantity());
        });
        return orderGroupApiLogicService.updateCart(request);
    }

    @PutMapping("/order")
    public Header<OrderGroupApiResponse> order(@RequestBody Header<OrderGroupApiRequest> request) {
        return orderGroupApiLogicService.order(request);
    }

    @GetMapping(value = "/order/{id}",produces = MediaTypes.HAL_JSON_VALUE)
    @ResponseStatus(HttpStatus.OK)
    public ResponseEntity readOrder(@PathVariable("id") Long orderGroupId) {
        URI uri = linkTo(OrderGroupApiController.class).slash(orderGroupId).withSelfRel().toUri();
        return orderGroupViewService.readOrder(orderGroupId)
                .map(orderGroupApiResponse ->
                    ResponseEntity.ok().body(
                            EntityModel.of(orderGroupApiResponse)
                            .add(linkTo(OrderGroupApiController.class).slash(orderGroupId).withSelfRel())
                    )
                ).orElseGet(() -> ResponseEntity.notFound().build());
    }


    @PutMapping("/order/modify")
    public Header<OrderGroupApiResponse> modifyOrder(@RequestBody Header<OrderGroupApiRequest> request) {
        return orderGroupApiLogicService.modifyOrder(request);
    }


    @DeleteMapping("/order/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public Header orderCancel(@PathVariable("id") Long orderGroupId) {
        return orderGroupApiLogicService.cancelOrder(orderGroupId);
    }
}
