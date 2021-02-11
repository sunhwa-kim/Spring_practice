package com.sh.adm.model.network.response;

import com.sh.adm.model.dto.Address;
import com.sh.adm.model.entity.Delivery;
import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.enumclass.OrderType;
import com.sh.adm.model.enumclass.PaymentType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderGroupApiResponse {
    private Long id;

    private OrderStatus status;

    private OrderType orderType;   // 묶음 , 개별

    private String revName;

    private String revAddress;

    private PaymentType paymentType;    // 현금, 카드,.

    private BigDecimal totalPrice;

    private Integer totalQuantity;

    private LocalDateTime orderAt;

    private LocalDate arrivalDate;

    private String orderDetailList;

    public void setOrder(Delivery delivery) {
        Address address = delivery.getReceiveAddress();
        this.revAddress = Arrays.asList(new String[]{address.getCity(), address.getCity(), address.getZipcode()}).stream().collect(Collectors.joining());
        this.revName = delivery.getReceiveName();
        this.arrivalDate = delivery.getArriveDate();
    }
}
