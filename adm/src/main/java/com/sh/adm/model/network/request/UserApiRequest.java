package com.sh.adm.model.network.request;


import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserApiRequest {
    private Long id;   // + update

    private String account;

    private String password;

    private String status;

    private String email;

    private String phoneNumber;

    //  요청 데이터만 정리, 서버 로직 데이터는 제외
}
