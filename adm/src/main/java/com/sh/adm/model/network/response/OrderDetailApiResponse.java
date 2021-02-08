package com.sh.adm.model.network.response;


import com.sh.adm.model.entity.OrderGroup;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@NoArgsConstructor
public class OrderDetailApiResponse {

    private Integer orderItemQuantity;

    private BigDecimal totalPrice;

    public OrderDetailApiResponse(Integer orderItemQuantity, BigDecimal totalPrice) {
        this.orderItemQuantity = orderItemQuantity;
        this.totalPrice = totalPrice;
    }
}
