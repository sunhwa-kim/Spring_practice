package com.sh.adm.model.dto;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;
import java.time.LocalDate;

@EqualsAndHashCode
@Getter
@NoArgsConstructor
@Embeddable
public class Birthday {
    private Integer yearOfBirthday;
    private Integer monthOfBirthday;
    private Integer dayOfBirthday;

    private Birthday(LocalDate birthday) {
        this.yearOfBirthday = birthday.getYear();
        this.monthOfBirthday = birthday.getMonthValue();
        this.dayOfBirthday = birthday.getDayOfMonth();
    }

    //static 생성자
    public static Birthday of(LocalDate birthday) {
        return new Birthday(birthday);
    }
}
