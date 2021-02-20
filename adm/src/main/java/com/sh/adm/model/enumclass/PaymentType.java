package com.sh.adm.model.enumclass;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum PaymentType {
    CARD(0,"카드","카드 결제"),
    BANK_TRANSFER(1,"현금","은행 계좌 현금 결제");

    private Integer id;
    private String title;
    private String description;
}
