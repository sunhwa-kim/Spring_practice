package com.sh.adm.orderdetail.exception;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class OrderDetailNotFoundException extends RuntimeException{
    private static final String MESSGAE ="주문 할 상품 정보가 없습니다.";
    public OrderDetailNotFoundException() {
        super(MESSGAE);
        log.error(MESSGAE);
    }
}
