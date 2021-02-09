package com.sh.adm.controller.api;

import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderDetailListApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderDetailListApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.service.OrderGroupApiLogicService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;


@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/cart")
public class OrderGroupApiController{

    private final OrderGroupApiLogicService orderGroupApiLogicService;

    @PostMapping("")
    @ResponseStatus(HttpStatus.CREATED)
    public Header<OrderDetailApiResponse> addToCart(@RequestBody Header<OrderDetailApiRequest> request) {
        /**
         *   장바구니 담기 버튼 -> ItemId [ OrderGroupId-> OrderDetail ]
         */
        return orderGroupApiLogicService.addToOrderDetail(request);
    }

    @PutMapping("/update")
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

    @GetMapping("/order/{id}")
    public Header<OrderGroupApiResponse> checkOrder(@PathVariable("id") Long orderGroupId) {
        return orderGroupApiLogicService.checkOrder(orderGroupId);
    }

    @PutMapping("/update_order")
    public Header<OrderGroupApiResponse> updateOrder(@RequestBody Header<OrderGroupApiRequest> request) {
        return orderGroupApiLogicService.updateOrder(request);
    }

    @DeleteMapping("/order/{id}")
    public Header cancelOrder(@PathVariable("id") Long orderGroupId) {
        return orderGroupApiLogicService.cancelOrder(orderGroupId);
    }
}
