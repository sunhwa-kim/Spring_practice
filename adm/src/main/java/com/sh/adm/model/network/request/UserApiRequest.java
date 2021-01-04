package com.sh.adm.model.network.request;


import com.sh.adm.model.enumclass.UserStatus;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
public class UserApiRequest {
    private Long id;   // + update

    private String account;

    private String password;

    private UserStatus status;

    private String email;

    private String phoneNumber;

    private LocalDateTime registeredAt;

    private LocalDateTime unregisteredAt;

    @Builder
    public UserApiRequest(Long id, String account, String password, UserStatus status, String email, String phoneNumber, LocalDateTime registeredAt, LocalDateTime unregisteredAt) {
        this.id = id;
        this.account = account;
        this.password = password;
        this.status = status;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.registeredAt = registeredAt;
        this.unregisteredAt = unregisteredAt;
    }
    //  요청 데이터만 정리, 서버 로직 데이터는 제외
}
