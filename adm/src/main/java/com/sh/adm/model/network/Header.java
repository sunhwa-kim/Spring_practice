package com.sh.adm.model.network;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
//@JsonInclude()   // 포함시킬 필드만 조절
public class Header<T> {

    // api 응답시간
    //    @JsonProperty("transaction_time")     // 응답시 각각에 대한 snake-case  -> 전체 : application.properties
    private LocalDateTime transactionTime;   //  ISO , YYYY-MM-DD hh:mm:ss ... 여러 방식

    // api 응답코드
    private String resultCode;

    // api 부가설명
    private String description;

    // data  (항상 변하는, generic으로 받아)
    private T data;

    // service 반환 형태
    //  OK
    public static <T> Header<T> OK() {
        //  (Header<T>) : (build 한 거 ) 형변환 까지 해줘야...
        return (Header<T>) Header.builder()
                .transactionTime(LocalDateTime.now())
                .resultCode("OK")
                .description("OK")
                .build();
    }

    //  DATA OK
    public static <T> Header<T> OK(T data) {
        return (Header<T>) Header.builder()
                .transactionTime(LocalDateTime.now())
                .resultCode("OK")
                .description("data OK")
                .data(data)
                .build();
    }

    // ERROR
    public static <T> Header<T> error(String description) {
        return (Header<T>) Header.builder()
                .transactionTime(LocalDateTime.now())
                .resultCode("ERROR")
                .description(description)
                .build();
    }
}
