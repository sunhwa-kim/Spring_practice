package com.sh.adm.model.network.response;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserApiResponse {
    // 왜 request와 response 분리?
    //  : 동일값에 대해 다른 정의로 보낼 수 있기 때문 (평문으로 받은 pwd 암호화 처리 응답, 가입/해지날짜 등)

    private Long id;

    private String account;

    private String password;

    private String status;

    private String email;

    private String phoneNumber;

    private LocalDateTime registeredAt;

    private LocalDateTime unregisteredAt;
}
