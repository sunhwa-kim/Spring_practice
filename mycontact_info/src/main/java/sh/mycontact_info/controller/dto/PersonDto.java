package sh.mycontact_info.controller.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotEmpty;
import java.time.LocalDate;

@Getter
@NoArgsConstructor
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

    public static PersonDto of(String name, String phoneNumber, String city, String street, String zipcode, LocalDate birthday) {
        return new PersonDto(name,phoneNumber,city,street,zipcode,birthday);
    }
}
