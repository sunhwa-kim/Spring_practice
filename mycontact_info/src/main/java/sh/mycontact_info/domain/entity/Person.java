package sh.mycontact_info.domain.entity;


import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Where;
import org.springframework.util.ObjectUtils;
import org.springframework.util.StringUtils;
import sh.mycontact_info.controller.dto.PersonDto;
import sh.mycontact_info.domain.Address;
import sh.mycontact_info.domain.Birthday;

import javax.persistence.*;
import java.time.LocalDate;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor(access = AccessLevel.PROTECTED)
@Where(clause = "deleted = false")
@Entity
public class Person {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "member_id")
    private Long id;

    //    @NotBlank   //  view : @NotEmpty(message = "회원 이름은 필수 입니다")
    private String name;

    private String phoneNumber;   //  view : @NotEmpty(message = "회원 폰번호는 필수 입니다")

    @Embedded
    private Address address;

    @Embedded
    private Birthday birthday;

    @ColumnDefault("0")
    private boolean deleted;


    public static Person of(PersonDto personDto) {
        Person person = new Person();
        person.name = personDto.getName();
        person.phoneNumber = personDto.getPhoneNumber();
        person.address = Address.of(personDto.getCity(), personDto.getStreet(), personDto.getZipcode());
        person.birthday = Birthday.of(personDto.getBirthday());
        return person;
    }

    public void set(PersonDto personDto) {  // 처음 등록 + 수정시 체크제외
        if( !ObjectUtils.isEmpty(personDto.getName())) this.name = personDto.getName();
        if (!ObjectUtils.isEmpty(personDto.getCity()) || !ObjectUtils.isEmpty(personDto.getStreet()) || !ObjectUtils.isEmpty(personDto.getZipcode())) {
            this.address = Address.of(personDto.getCity(), personDto.getStreet(), personDto.getZipcode());
        }
        if(!ObjectUtils.isEmpty(personDto.getBirthday())) this.birthday = Birthday.of(personDto.getBirthday());
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

}
