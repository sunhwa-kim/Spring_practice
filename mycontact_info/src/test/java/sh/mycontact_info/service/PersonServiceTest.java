package sh.mycontact_info.service;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import sh.mycontact_info.controller.dto.PersonDto;
import sh.mycontact_info.domain.entity.Person;
import sh.mycontact_info.repository.PersonRepository;

import java.time.LocalDate;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
class PersonServiceTest {

    @InjectMocks
    PersonService personService;

    @Mock
    PersonRepository personRepository;

    @Test
    @DisplayName("연락처 등록 테스트")
    void postPersonTest() {
        PersonDto dto = PersonDto.of("kamill", "010-1234-1234", "seoul", "road", "1111", LocalDate.of(2000, 1, 1));
        personService.savePerson(dto);
        verify(personRepository, times(1)).save(any(Person.class));
    }



}