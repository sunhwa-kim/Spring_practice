package com.sh.adm.exception;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class OrderGroupNotFoundException extends RuntimeException{
    private static final String MESSGAE ="장바구니에 상품이 없습니다.";
    public OrderGroupNotFoundException() {
        super(MESSGAE);
        log.error(MESSGAE);
    }
}
