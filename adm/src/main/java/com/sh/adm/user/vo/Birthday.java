package com.sh.adm.user.vo;

import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.apache.tomcat.jni.Local;

import javax.persistence.Embeddable;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@EqualsAndHashCode
@Getter
@NoArgsConstructor
@Embeddable
public class Birthday {
    private Integer yearOfBirthday;
    private Integer monthOfBirthday;
    private Integer dayOfBirthday;


    public Birthday(Integer yearOfBirthday, Integer monthOfBirthday, Integer dayOfBirthday) {
        this.yearOfBirthday = yearOfBirthday;
        this.monthOfBirthday = monthOfBirthday;
        this.dayOfBirthday = dayOfBirthday;
    }

    public Birthday(LocalDate birthday) {
        this.yearOfBirthday = birthday.getYear();
        this.monthOfBirthday = birthday.getMonthValue();
        this.dayOfBirthday = birthday.getDayOfMonth();
    }

    //static 생성자
    public static Birthday of(String birthday) {
        LocalDate localDate = parseLocalDate(birthday);
        return new Birthday(localDate.getYear(), localDate.getDayOfMonth(), localDate.getDayOfYear());
    }

    private static LocalDate parseLocalDate(String birthday) {
        return LocalDate.parse(birthday, DateTimeFormatter.ofPattern("yyyyMMdd"));
    }

    public LocalDate getLocalDate(){
        return LocalDate.of(this.yearOfBirthday, this.monthOfBirthday, this.dayOfBirthday);
    }
}
