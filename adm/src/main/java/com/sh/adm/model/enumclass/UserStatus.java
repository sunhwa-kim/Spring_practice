package com.sh.adm.model.enumclass;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor     // enum 안 모두 들어가게
public enum UserStatus {

    REGISTERED(0,"등록", "사용자 등록 상태"),
    UNREGISTERED(1, "해지", "사용자 해지 상태");

    private Integer id;  // 2개뿐 이니 Integer (No Long)
    private String title;
    private String description;


}
