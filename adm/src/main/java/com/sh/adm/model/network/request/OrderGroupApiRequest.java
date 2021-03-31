package com.sh.adm.model.network.request;

import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.enumclass.OrderType;
import com.sh.adm.model.enumclass.PaymentType;
import lombok.*;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.math.BigDecimal;

@Data
@NoArgsConstructor
public class OrderGroupApiRequest {
    private Long id;   // order_group_id for update

    private OrderStatus status;

    @NotEmpty(message = "배송 방식을 지정해 주세요")  // select
    private OrderType orderType;   // 묶음 , 개별

    @NotEmpty(message = "결제 방식을 지정해 주세요")
    private PaymentType paymentType;    // 현금, 카드,.

    private BigDecimal totalPrice;

    private Integer totalQuantity;

    // Delivery
    @NotBlank(message = "배송지 도시명 입력해 주세요")
    private String city;
    @NotBlank(message = "배송지 도로명 입력해 주세요")
    private String street;
    @NotBlank(message = "배송지 우편주소 입력해 주세요")
    private String zipcode;

    private String receiveName;

    @Builder
    public OrderGroupApiRequest(Long id, OrderStatus status, OrderType orderType, PaymentType paymentType, BigDecimal totalPrice, Integer totalQuantity, String city, String street, String zipcode, String receiveName) {
        this.id = id;
        this.status = status;
        this.orderType = orderType;
        this.paymentType = paymentType;
        this.totalPrice = totalPrice;
        this.totalQuantity = totalQuantity;
        this.city = city;
        this.street = street;
        this.zipcode = zipcode;
        this.receiveName = receiveName;
    }
}
