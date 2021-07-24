package com.sh.adm.ordergroup.controller;

import com.sh.adm.ordergroup.exception.OrderGroupNotFoundException;
import com.sh.adm.exception.dto.ErrorResponse;
import com.sh.adm.orderdetail.exception.OrderDetailNotFoundException;
import com.sh.adm.item.exception.ItemNotFoundException;
import com.sh.adm.model.network.SimpleResponse;
import com.sh.adm.ordergroup.dto.OrderGroupApiRequest;
import com.sh.adm.ordergroup.dto.OrderGroupApiResponse;
import com.sh.adm.ordergroup.service.OrderGroupSaveService;
import com.sh.adm.ordergroup.service.OrderGroupViewService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.MediaTypes;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;


@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/order")
public class OrderGroupApiController {

    private final OrderGroupViewService orderGroupViewService;
    private final OrderGroupSaveService orderGroupSaveService;

    @PutMapping("")
    public ResponseEntity<OrderGroupApiResponse> order(@RequestBody OrderGroupApiRequest request) {
        OrderGroupApiResponse responseBody = orderGroupSaveService.order(request);
        return ResponseEntity.ok(responseBody);
    }

    @GetMapping(value = "/{id}",produces = MediaTypes.HAL_JSON_VALUE)
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

    @PutMapping("/modify")
    public ResponseEntity modifyOrder(@RequestBody OrderGroupApiRequest request) {
        return orderGroupSaveService.modifyOrder(request)
                .map(orderGroupApiResponse ->
                        ResponseEntity.ok().body(
                                EntityModel.of(orderGroupApiResponse)
                                        .add(linkTo(OrderGroupApiController.class).slash(request.getId()).withSelfRel())
                        )
                ).orElseGet(() -> ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public ResponseEntity orderCancel(@PathVariable("id") Long orderGroupId) {
        orderGroupSaveService.cancelOrder(orderGroupId);
        return ResponseEntity.ok(new SimpleResponse(true,"delested"));
    }

    @ExceptionHandler(OrderGroupNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleOrderGroupNotFoundException(OrderGroupNotFoundException exception) {
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
