package com.sh.adm.exception;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class NotPermittedChageOrder extends RuntimeException {
    private static final String MESSGAE ="Already delivered, Cannot Change Order";

    public NotPermittedChageOrder() {
        super(MESSGAE);
        log.error(MESSGAE);
    }
}
