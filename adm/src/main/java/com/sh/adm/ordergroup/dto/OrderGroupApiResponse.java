package com.sh.adm.ordergroup.dto;

import com.sh.adm.user.vo.Address;
import com.sh.adm.deliverry.entity.Delivery;
import lombok.*;

import javax.validation.constraints.NotBlank;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.stream.Collectors;
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderGroupApiResponse {
    private Long id;  // OrderGroupId

    private String status;

    private String orderType;   // 묶음 , 개별

    private String receiveName;

    @NotBlank
    private String revAddress;

    private String paymentType;    // 현금, 카드,.
    @NotBlank
    private BigDecimal totalPrice;
    @NotBlank
    private Integer totalQuantity;

    private LocalDateTime orderAt;

    private LocalDate arrivalDate;

    private String orderDetailListName;  // 주문 목록 title 명

    public void setOrder(Delivery delivery) {
        Address address = delivery.getReceiveAddress();
        this.revAddress = Arrays.asList(new String[]{address.getCity(), address.getStreet(), address.getZipcode()}).stream().collect(Collectors.joining(", "));
        this.receiveName = delivery.getReceiveName();
        this.arrivalDate = delivery.getArriveDate();
    }

    public void setOrderDetailList(String orderDetailName) {
        this.orderDetailListName = orderDetailName +"외 "+ this.totalQuantity + "개 주문";
    }
}
