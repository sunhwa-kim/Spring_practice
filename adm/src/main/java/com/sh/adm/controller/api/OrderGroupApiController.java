package com.sh.adm.controller.api;

import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderDetailApiResponse;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.service.OrderGroupApiLogicService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;


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

    @PatchMapping("{id}")
    public Header<OrderDetailApiResponse> updateCartItem(@PathVariable("id") Long orderDetailId, int orderCount) {
        return orderGroupApiLogicService.updateCart(orderDetailId, orderCount);
    }

    @PostMapping("/order")
    @ResponseStatus(HttpStatus.CREATED)
    public Header<OrderGroupApiResponse> order(Header<OrderGroupApiRequest> request) {
        return orderGroupApiLogicService.order(request);
    }

    @GetMapping("/order/{id}")
    public Header<OrderGroupApiResponse> checkOrder(@PathVariable("id") Long orderGroupId) {
        return orderGroupApiLogicService.checkOrder(orderGroupId);
    }

    @PutMapping("")
    public Header<OrderGroupApiResponse> updateOrder(Header<OrderGroupApiRequest> request) {
        return orderGroupApiLogicService.updateOrder(request);
    }

    @DeleteMapping("{id}")
    public Header cancelOrder(@PathVariable("id") Long orderGroupId) {
        return orderGroupApiLogicService.cancelOrder(orderGroupId);
    }
}
