package com.sh.adm.exception;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class OrderGroupNotFoundException extends RuntimeException{
    private static final String MESSGAE ="장바구니에 상품을 담아야 합니다.";
    public OrderGroupNotFoundException() {
        super(MESSGAE);
        log.error(MESSGAE);
    }
}
