package com.sh.adm.user.model.dto;


import com.sh.adm.user.enumclass.UserStatus;
import lombok.*;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
public class UserApiRequest {
    private Long id;   // + update

    @NotBlank
    private String account;

    private String password;

    private UserStatus status;   // UserStatus

    private String email;

    private String phoneNumber;

    @Length(min = 8, max = 8)
    private String birthday;

    private LocalDateTime registeredAt;

    private LocalDateTime unregisteredAt;

    public UserApiRequest(Long id, String account, String password, UserStatus status, String email, String phoneNumber, String birthday, LocalDateTime registeredAt, LocalDateTime unregisteredAt) {
        this.id = id;
        this.account = account;
        this.password = password;
        this.status = status;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.birthday = birthday;
        this.registeredAt = registeredAt;
        this.unregisteredAt = unregisteredAt;
    }

}
