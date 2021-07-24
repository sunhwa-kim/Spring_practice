package com.sh.adm.orderdetail.controller;

import com.sh.adm.item.exception.ItemNotFoundException;
import com.sh.adm.ordergroup.exception.OrderGroupNotFoundException;
import com.sh.adm.exception.dto.ErrorResponse;
import com.sh.adm.orderdetail.exception.OrderDetailNotFoundException;
import com.sh.adm.model.network.SimpleResponse;
import com.sh.adm.orderdetail.dto.OrderDetailApiRequest;
import com.sh.adm.orderdetail.dto.OrderDetailApiResponse;
import com.sh.adm.orderdetail.service.OrderDetailService;
import com.sh.adm.user.exception.UserNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.hateoas.EntityModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;


@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/cart")
public class OrderDetailApiController {

    private final OrderDetailService orderDetailService;

    @PostMapping("")
    @ResponseStatus(HttpStatus.CREATED)
    public ResponseEntity cart(@RequestBody OrderDetailApiRequest request) {
        // 장바구니 담기
        orderDetailService.addToOrderDetail(request);
        return ResponseEntity.ok(new SimpleResponse(true,"saved"));
    }

    @PatchMapping("{id}")
    public ResponseEntity modifyCart(@PathVariable("id") Long orderGorupId, @RequestBody OrderDetailApiRequest request) {
        OrderDetailApiResponse response = orderDetailService.modifyOrderDetail(orderGorupId, request);
        return ResponseEntity.ok().body(
                EntityModel.of(response)
                        .add(linkTo(OrderDetailApiController.class).slash(response.getId()).withSelfRel()));
    }

    @DeleteMapping("")
    public ResponseEntity deleteCart(@RequestBody OrderDetailApiRequest request) {
        orderDetailService.deleteCart(request);
        return ResponseEntity.ok(new SimpleResponse(true,"delested"));
    }

    @ExceptionHandler(UserNotFoundException.class)
    public ResponseEntity<ErrorResponse> handleUserNotFoundException(UserNotFoundException exception) {
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
