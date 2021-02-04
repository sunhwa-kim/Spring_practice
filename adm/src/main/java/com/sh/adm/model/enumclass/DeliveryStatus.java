package com.sh.adm.model.enumclass;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum DeliveryStatus {
    READY(0,"배송 준비 중","배송 준비 중입니다."),
    DELIVERING(1,"배송 중","배송 중 입니다."),
    COMPLETE(2,"배송 완료","배송 도착 했습니다.");

    private Integer id;
    private String process;
    private String description;
}
