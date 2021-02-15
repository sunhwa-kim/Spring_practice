package sh.mycontact_info.service;

import org.assertj.core.util.Lists;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Captor;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import sh.mycontact_info.controller.dto.PersonDto;
import sh.mycontact_info.domain.Address;
import sh.mycontact_info.domain.Birthday;
import sh.mycontact_info.domain.entity.Person;
import sh.mycontact_info.exception.UniquePhoneNumberException;
import sh.mycontact_info.repository.PersonRepository;

import java.time.LocalDate;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
import static org.assertj.core.api.BDDAssertions.then;
import static org.junit.jupiter.api.Assertions.assertAll;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class PersonServiceTest {

    @InjectMocks
    private PersonService personService;

    @Mock
    private PersonRepository personRepository;

    @Captor
    private ArgumentCaptor<Person> argumentCaptor;


    private String name = "kamill";
    private String phoneNumber = "010-1234-1234";
    private String city = "seoul";
    private String street = "road";
    private String zipcode = "1111";
    private LocalDate birthdy = LocalDate.of(2000, 1, 1);

    @Test
    @DisplayName("연락처 중복 저장 테스트")
    void validateDupliateOfPhoneNumber() {
        when(personRepository.countByPhoneNumber(phoneNumber)).thenReturn(1L);
        assertThatExceptionOfType(UniquePhoneNumberException.class).isThrownBy(
                () -> personService.put(requestPersonDto())
        ).withMessage("동일 번호는 저장 하실 수 없습니다.");
    }

    @Test
    @DisplayName("지인 등록 테스트")
    void postPersonTest() {
        when(personRepository.save(any(Person.class))).thenReturn(testPerson());
        personService.put(requestPersonDto());
        verify(personRepository, times(1)).save(argumentCaptor.capture());
        assertAll(
                () -> then(argumentCaptor.getValue()).isNotNull(),
                () -> then(argumentCaptor.getValue().getName()).isEqualTo(name),
                () -> then(argumentCaptor.getValue().getPhoneNumber()).isEqualTo(phoneNumber),
                () -> then(argumentCaptor.getValue().getAddress()).isEqualTo(Address.of(city, street, zipcode)),
                () -> then(argumentCaptor.getValue().getBirthday()).isEqualTo(Birthday.of(birthdy))
        );
    }

    @Test
    @DisplayName("상세 조회")
    void getPersonDetail() {
        when(personRepository.findById(1L)).thenReturn(Optional.of(testPerson()));
        Person person = personService.getPerson(1L);
        assertAll(
                () -> then(person.getName()).isEqualTo(name),
                () -> then(person.getPhoneNumber()).isEqualTo(phoneNumber),
                () -> then(person.getAddress()).isEqualTo(Address.of(city, street, zipcode)),
                () -> then(person.getBirthday()).isEqualTo(Birthday.of(birthdy))
        );
    }

    @Test
    @DisplayName("상세 조회 대상 없을 때")
    void getPersonIsNotFound() {
        when(personRepository.findById(1L)).thenReturn(Optional.empty());
        Person person = personService.getPerson(1L);
        then(person).isNull();
    }

    @Test
    @DisplayName("지인 정보 변경")
    void updatePerson() {
        when(personRepository.findById(1L)).thenReturn(Optional.of(testPerson()));
        personService.modify(1L, requestPersonDto());

/*
        verify(personRepository, times(1)).save(argumentCaptor.capture());
        assertAll(
                () -> then(argumentCaptor.getValue()).isNotNull(),
                () -> then(argumentCaptor.getValue().getName()).isEqualTo(name),
                () -> then(argumentCaptor.getValue().getPhoneNumber()).isEqualTo(phoneNumber),
                () -> then(argumentCaptor.getValue().getAddress()).isEqualTo(Address.of(city, "2021", zipcode)),
                () -> then(argumentCaptor.getValue().getBirthday()).isEqualTo(Birthday.of(birthdy))
        );*/
    }

    private Person testPerson() {
        return Person.of(requestPersonDto());
    }

    private PersonDto requestPersonDto() {
        return PersonDto.builder()
                .name(name)
                .phoneNumber(phoneNumber)
                .city(city)
                .street(street)
                .zipcode(zipcode)
                .birthday(birthdy)
                .build();
    }
}