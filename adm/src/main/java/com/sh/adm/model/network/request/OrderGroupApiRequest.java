package com.sh.adm.model.network.request;

import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.enumclass.OrderType;
import lombok.*;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
//@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderGroupApiRequest {
    private Long id;   // update

    private OrderStatus status;

    private OrderType orderType;   // 묶음 , 개별

    private String paymentType;    // 현금, 카드,.

    private BigDecimal totalPrice;

    private Integer totalQuantity;

    private LocalDateTime orderAt;

    private Long userId;
}
