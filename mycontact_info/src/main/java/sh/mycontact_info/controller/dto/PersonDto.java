package sh.mycontact_info.controller.dto;

import lombok.*;

import javax.validation.constraints.NotEmpty;
import java.time.LocalDate;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class PersonDto {

    @NotEmpty(message = "이름은 필수 입니다")
    private String name;
    
    @NotEmpty(message = "폰번호는 필수 입니다")
    private String phoneNumber;

    private String city;
    private String street;
    private String zipcode;

    private LocalDate birthday;

    @Builder
    public PersonDto(@NotEmpty(message = "이름은 필수 입니다") String name, @NotEmpty(message = "폰번호는 필수 입니다") String phoneNumber, String city, String street, String zipcode, LocalDate birthday) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.city = city;
        this.street = street;
        this.zipcode = zipcode;
        this.birthday = birthday;
    }
}
