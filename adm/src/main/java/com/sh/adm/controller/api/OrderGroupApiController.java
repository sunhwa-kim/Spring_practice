package com.sh.adm.controller.api;

import com.sh.adm.exception.ItemNotFoundException;
import com.sh.adm.exception.OrderGroupNotFoundException;
import com.sh.adm.exception.dto.ErrorResponse;
import com.sh.adm.exception.dto.OrderDetailNotFoundException;
import com.sh.adm.model.network.SimpleResponse;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.service.ordergroup.OrderGroupSaveService;
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
    private final OrderGroupSaveService orderGroupSaveService;

    @PostMapping("")
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity cart(@RequestBody @Valid OrderDetailApiRequest request) {
        // 장바구니 담기
        try {
            orderGroupSaveService.addToOrderDetail(request);
        } catch (Exception e) {
            ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(new SimpleResponse(true,"saved"));
    }

    @PutMapping("")
    public ResponseEntity modifyCart(@RequestBody @Valid OrderDetailApiRequest request) {
        OrderDetailApiResponse response = orderGroupSaveService.modifyCart(request);
        return ResponseEntity.ok().body(
                EntityModel.of(response)
                        .add(linkTo(OrderGroupApiController.class).slash(response.getId()).withSelfRel()));
    }

    @DeleteMapping("")
    public ResponseEntity deleteCart(@RequestBody OrderDetailApiRequest request) {
        orderGroupSaveService.deleteCart(request);
        return ResponseEntity.ok(new SimpleResponse(true,"delested"));
    }

/*    @PutMapping("")
    public ResponseEntity updateCart(@RequestBody Header<OrderDetailListApiRequest> headerRequest) {
        OrderDetailListApiRequest request = headerRequest.getData();
        OrderDetailListApiResponse response = orderGroupSaveService.updateCart(request);
        return ResponseEntity.ok().body(
                        EntityModel.of(response)
                                .add(linkTo(OrderGroupApiController.class).slash(response.getOrder_group_id()).withSelfRel()));
    }*/

    @PutMapping("/order")
    public ResponseEntity<OrderGroupApiResponse> order(@RequestBody @Valid OrderGroupApiRequest request) {
        OrderGroupApiResponse responseBody = orderGroupSaveService.order(request);
        return ResponseEntity.ok(responseBody);
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
    public ResponseEntity modifyOrder(@RequestBody OrderGroupApiRequest request) {
        return orderGroupSaveService.modifyOrder(request)
                .map(orderGroupApiResponse ->
                        ResponseEntity.ok().body(
                                EntityModel.of(orderGroupApiResponse)
                                        .add(linkTo(OrderGroupApiController.class).slash(request.getId()).withSelfRel())
                        )
                ).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @DeleteMapping("/order/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public ResponseEntity orderCancel(@PathVariable("id") Long orderGroupId) {
        orderGroupSaveService.cancelOrder(orderGroupId);
        return ResponseEntity.ok(new SimpleResponse(true,"delested"));
    }

    @ExceptionHandler(OrderGroupNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleOrderGroupNotFoundException(OrderGroupNotFoundException exception) {
        return new ResponseEntity<>(ErrorResponse.of(HttpStatus.BAD_REQUEST, exception.getMessage()), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(ItemNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleItemNotFoundException(ItemNotFoundException exception) {
        return new ResponseEntity<>(ErrorResponse.of(HttpStatus.BAD_REQUEST, exception.getMessage()), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(OrderDetailNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleOrderDetailNotFoundException(OrderDetailNotFoundException exception) {
        return new ResponseEntity<>(ErrorResponse.of(HttpStatus.BAD_REQUEST, exception.getMessage()), HttpStatus.BAD_REQUEST);
    }


    @ExceptionHandler(value = RuntimeException.class)
    public ResponseEntity<ErrorResponse> handleRuntimeException(RuntimeException ex) {
        log.error("서버오류 : {}", ex.getMessage(), ex);
        return new ResponseEntity<>(ErrorResponse.of(HttpStatus.INTERNAL_SERVER_ERROR, "알 수 없는 서버 오류가 발생하였습니다"), HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
