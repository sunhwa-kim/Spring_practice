package com.sh.adm.user.enumclass;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserAccount {
    CREATE(0,"사용자 생성 중복 체크"),
    UPDATED(1,"사용자 계졍 변경 불가");

    private Integer id;
    private String description;
}
