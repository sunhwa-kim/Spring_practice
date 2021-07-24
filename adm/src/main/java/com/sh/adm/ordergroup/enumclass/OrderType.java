package com.sh.adm.ordergroup.enumclass;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum OrderType {
    ALL(0,"묶음","모든 상품 묶음 배송"),
    SPLIT(1,"개별","모든 상품을 준비되는 대로 발송");

    private Integer id;
    private String title;
    private String description;
}
