package com.sh.adm.model.network.response;


import com.sh.adm.model.enumclass.OrderStatus;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
public class OrderDetailApiResponse {

    @NotBlank
    private Integer id;  // 장바구니 index

    private String orderStatus;

    private LocalDate arrivalDate;
    @NotBlank
    private Integer quantity;

    private BigDecimal totalPrice;

    @NotBlank
    private Long orderGroupId;

    @NotBlank(message="상품을 선택해 주세요")
    private Long itemId;

    @Builder
    public OrderDetailApiResponse(int id, String orderStatus, LocalDate arrivalDate, Integer quantity, BigDecimal totalPrice, Long orderGroupId, Long itemId) {
        this.id = id;
        this.orderStatus = orderStatus;
        this.arrivalDate = arrivalDate;
        this.quantity = quantity;
        this.totalPrice = totalPrice;
        this.orderGroupId = orderGroupId;
        this.itemId = itemId;
    }
}
