package sh.mycontact_info.domain;

import lombok.EqualsAndHashCode;
import lombok.Getter;

import javax.persistence.Embeddable;

@Getter
@EqualsAndHashCode
@Embeddable
public class Address {
    private String city;
    private String street;
    private String zipcode;

    protected Address() {
        // for jpa spec
    }

    private Address(String city, String street, String zipcode) {
        this.city = city;
        this.street = street;
        this.zipcode = zipcode;
    }

    public static Address of(String city, String street, String zipcode) {
        return new Address(city, street, zipcode);
    }
}
