package com.sh.adm.model.enumclass;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserGrade {
    GOLD(0,"VVIP", "사용자 최고 등급"),
    SILVER(1, "VIP", "사용자 우대 등급"),
    BRONZE(2, "IP", "사용자 이용 등급");

    private Integer id;
    private String title;
    private String description;
}
