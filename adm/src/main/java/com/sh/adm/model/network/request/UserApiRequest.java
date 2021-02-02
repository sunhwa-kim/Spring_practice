package com.sh.adm.model.network.request;


import com.sh.adm.model.enumclass.UserStatus;
import lombok.*;

import javax.validation.constraints.NotEmpty;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class
UserApiRequest {
    private Long id;   // + update

    @NotEmpty(message = "계정명은 필수 입니다.")
    private String account;
    
    private String password;

    private UserStatus status;

    private String email;

    @NotEmpty(message = "폰번호는 필수 입니다.")
    private String phoneNumber;

    private LocalDate birthday;

    private LocalDateTime registeredAt;

    private LocalDateTime unregisteredAt;

    public static UserApiRequest of(Long id, String account, String password, UserStatus status, String email, String phoneNumber,LocalDate bithday,LocalDateTime registeredAt, LocalDateTime unregisteredAt) {
        return new UserApiRequest(id, account, password, status, email, phoneNumber, bithday, registeredAt, unregisteredAt);
    }
}
