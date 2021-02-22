package com.sh.adm.exception.dto;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;

@Slf4j
@AllArgsConstructor(access = AccessLevel.PRIVATE)
public class ErrorResponse {
    private int code;
    private String message;

    public static ErrorResponse of(HttpStatus httpStatus, String message) {
        return new ErrorResponse(httpStatus.value(), message);
    }
}
