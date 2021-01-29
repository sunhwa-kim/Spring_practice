package sh.mycontact_info.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sh.mycontact_info.controller.dto.PersonDto;
import sh.mycontact_info.domain.entity.Person;
import sh.mycontact_info.exception.UniquePhoneNumberException;
import sh.mycontact_info.repository.PersonRepository;

@RequiredArgsConstructor
@Service
public class PersonService {

    private final PersonRepository personRepository;

    @Transactional
    public void savePerson(PersonDto personDto) {
        Person person = new Person();
        if(!personRepository.findByPhoneNumber(personDto.getPhoneNumber()).isEmpty()) throw new UniquePhoneNumberException("This phone number already exists");
        person.set(personDto);
        person.setName(personDto.getName());   // 수정시 체크 위해 분리
        person.setPhoneNumber(personDto.getPhoneNumber());
        personRepository.save(person);
    }

}
