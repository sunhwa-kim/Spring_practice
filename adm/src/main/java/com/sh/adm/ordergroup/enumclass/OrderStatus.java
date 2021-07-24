package com.sh.adm.ordergroup.enumclass;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@JsonFormat(shape = JsonFormat.Shape.STRING)
public enum OrderStatus {
    ORDERING(0,"주문 중","장바구니 대기 상태"),
    CONFIRM(1,"주문 확인","주문 요청 받은 후 주문 진행"),
    COMPLETE(2,"주문 완료","주문이 완료 됐습니다.(배송 도착 별도)");

    private Integer id;
    private String title;
    private String description;
}
