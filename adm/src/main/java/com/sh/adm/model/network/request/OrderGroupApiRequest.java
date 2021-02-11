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
public class OrderGroupApiRequest {
    private Long id;   // order_group_id

    private OrderStatus status;

    @NotEmpty(message = "배송 방식을 지정해 주세요")
    private OrderType orderType;   // 묶음 , 개별

    @NotEmpty(message = "결제 방식을 지정해 주세요")
    private PaymentType paymentType;    // 현금, 카드,.

    private BigDecimal totalPrice;

    private Integer totalQuantity;

//    private LocalDateTime orderAt;   // OrderGroup method : takeAnOrder()

    // Delivery
    private String city;
    private String street;
    private String zipcode;

    private String receiveName;

    // OrderDetail
//    @NotEmpty(message = "상품 없이 주문 할 수 없습니다.")
//    private String orderDetailsId;  // 내부 조회 -> "id,id,id"  변경 예정 (사용자 확인 로직 고민)

    @Builder
    public OrderGroupApiRequest(Long id, OrderStatus status, OrderType orderType, PaymentType paymentType, BigDecimal totalPrice, Integer totalQuantity, String city, String street, String zipcode, String receiveName) {
        this.id = id;
        this.status = status;
        this.orderType = orderType;
        this.paymentType = paymentType;
        this.totalPrice = totalPrice;   // view 계산로직과 DB비교 체크용
        this.totalQuantity = totalQuantity;  // view 계산로직과 DB비교 체크용
        this.city = city;
        this.street = street;
        this.zipcode = zipcode;
        this.receiveName = receiveName;
//        this.orderDetailsId = orderDetailId;
    }
}
