package com.sh.adm.model.dto;

import lombok.*;

import javax.persistence.Embeddable;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Embeddable
public class Address {
    private String city;
    private String street;
    private String zipcode;

    public static Address of(String city, String street, String zipcode) {
        return new Address(city,street,zipcode);
    }
}
