package com.sh.adm.model.network.request;

import com.sh.adm.model.enumclass.DeliveryStatus;
import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.enumclass.OrderType;
import com.sh.adm.model.enumclass.PaymentType;
import lombok.*;

import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.validation.constraints.NotEmpty;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class OrderGroupApiRequest {
    private Long id;   // update

    private OrderStatus status;

    private OrderType orderType;   // 묶음 , 개별

    private PaymentType paymentType;    // 현금, 카드,.

    private BigDecimal totalPrice;

    private Integer totalQuantity;

    private LocalDateTime orderAt;


    // Delivery
    private String city;
    private String street;
    private String zipcode;

    private String receiveName;

    private Long userId;

    // OrderDetail
    @NotEmpty(message = "상품 없이 주문 할 수 없습니다.")
    private String orderDetailsId;

    @Builder
    public OrderGroupApiRequest(Long id, OrderStatus status, OrderType orderType, PaymentType paymentType, BigDecimal totalPrice, Integer totalQuantity, LocalDateTime orderAt, Long userId, String city, String street, String zipcode, String receiveName, @NotEmpty(message = "상품 없이 주문 할 수 없습니다.") String orderDetailId) {
        this.id = id;
        this.status = status;
        this.orderType = orderType;
        this.paymentType = paymentType;
        this.totalPrice = totalPrice;
        this.totalQuantity = totalQuantity;
        this.orderAt = orderAt;
        this.city = city;
        this.street = street;
        this.zipcode = zipcode;
        this.receiveName = receiveName;
        this.userId = userId;
        this.orderDetailsId = orderDetailId;
    }
}
