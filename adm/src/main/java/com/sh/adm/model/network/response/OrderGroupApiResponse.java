package com.sh.adm.model.network.response;

import com.sh.adm.model.enumclass.OrderType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
//@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderGroupApiResponse {
    private Long id;

    private String status;

    private OrderType orderType;   // 묶음 , 개별

    private String revAddress;

    private String revName;

    private String paymentType;    // 현금, 카드,.

    private BigDecimal totalPrice;

    private Integer totalQuantity;

    private LocalDateTime orderAt;

    private LocalDateTime arrivalDate;

    private Long userId;
}
