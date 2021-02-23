package com.sh.adm.model.network.request;


import com.sh.adm.model.enumclass.OrderStatus;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
public class OrderDetailApiRequest {

    private Integer id;  // 장바구니 index

    private OrderStatus orderStatus;

    private LocalDate arrivalDate;

    private Integer quantity;

    private BigDecimal totalPrice;

    @NotBlank
    private Long userId;
    @NotBlank
    private Long orderGroupId;

    @NotBlank(message="상품을 선택해 주세요")
    private Long itemId;

    @Builder
    public OrderDetailApiRequest(int id, OrderStatus orderStatus, LocalDate arrivalDate, Integer quantity, BigDecimal totalPrice, Long userId,Long orderGroupId, Long itemId) {
        this.id = id;
        this.orderStatus = orderStatus;
        this.arrivalDate = arrivalDate;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.userId = userId;
        this.orderGroupId = orderGroupId;
        this.itemId = itemId;
    }
}
