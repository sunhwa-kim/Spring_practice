package sh.mycontact_info.domain.entity;


import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Where;
import sh.mycontact_info.domain.Address;
import sh.mycontact_info.domain.Birthday;

import javax.persistence.*;
import java.time.LocalDate;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@AllArgsConstructor
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

    public Person(String name, String phoneNumber, Address address, Birthday birthday) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.birthday = birthday;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }
}
