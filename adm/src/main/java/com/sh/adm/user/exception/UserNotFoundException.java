package com.sh.adm.user.exception;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class UserNotFoundException extends RuntimeException{
    private static final String MESSGAE ="없는 사용자 정보 입니다.";
    public UserNotFoundException() {
        super(MESSGAE);
        log.error(MESSGAE);
    }
}
