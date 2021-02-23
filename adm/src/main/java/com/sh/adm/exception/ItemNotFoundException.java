package com.sh.adm.exception;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ItemNotFoundException extends RuntimeException{
    private static final String MESSGAE ="해당 상품이 없습니다.";
    public ItemNotFoundException() {
        super(MESSGAE);
        log.error(MESSGAE);
    }
}
