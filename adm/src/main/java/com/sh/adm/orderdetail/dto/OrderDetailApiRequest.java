package com.sh.adm.orderdetail.dto;


import com.sh.adm.ordergroup.enumclass.OrderStatus;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
@NoArgsConstructor
public class OrderDetailApiRequest {

    private Integer id;  // 장바구니 index

    private String orderStatus;

    private LocalDate arrivalDate;

    private Integer quantity;

    private BigDecimal totalPrice;

    private Long userId;

    private Long orderGroupId;
    @NotBlank(message="상품을 선택해 주세요")
    private Long itemId;

    @Builder
    public OrderDetailApiRequest(int id, OrderStatus orderStatus, LocalDate arrivalDate, Integer quantity, BigDecimal totalPrice, Long userId,Long orderGroupId, Long itemId) {
        this.id = id;
        this.orderStatus = orderStatus.getTitle();
        this.arrivalDate = arrivalDate;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.userId = userId;
        this.orderGroupId = orderGroupId;
        this.itemId = itemId;
    }
}
