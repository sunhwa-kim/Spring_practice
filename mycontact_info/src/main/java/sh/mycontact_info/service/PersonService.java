package sh.mycontact_info.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import sh.mycontact_info.controller.dto.PersonDto;
import sh.mycontact_info.domain.entity.Person;
import sh.mycontact_info.exception.PersonIsNotFoundException;
import sh.mycontact_info.exception.UniquePhoneNumberException;
import sh.mycontact_info.repository.PersonRepository;


@RequiredArgsConstructor
@Service
public class PersonService {

    private final PersonRepository personRepository;

    @Transactional(readOnly = true)
    public Person getPerson(Long id) {
        Person person = personRepository.findById(id).orElse(null);
        return person;
    }

    @Transactional
    public void put(PersonDto personDto) {
        ValidateDuplicatedPersonPhoneNumber(personDto.getPhoneNumber());
        personRepository.save(Person.of(personDto));
    }

    @Transactional
    public void modify(Long id, PersonDto personDto) {
        Person person = personRepository.findById(id).orElseThrow(PersonIsNotFoundException::new);
        if ( !person.getPhoneNumber().equals(personDto.getPhoneNumber()) )
            throw new RuntimeException("폰 번호는 변경 하실 수 없습니다.");
        person.set(personDto);
    }

    @Transactional
    public void modify(Long id, String phoneNumber) {
        Person person = personRepository.findById(id).orElseThrow(PersonIsNotFoundException::new);
        if ( !person.getPhoneNumber().equals(phoneNumber) )
            person.setPhoneNumber(phoneNumber);
    }

    @Transactional
    public void delete(Long id) {
        personRepository.findById(id)
                .ifPresentOrElse(person -> person.setDeleted(true),() -> new PersonIsNotFoundException());
    }

    private void ValidateDuplicatedPersonPhoneNumber(String phoneNumber) {
        Long phoneCount = personRepository.countByPhoneNumber(phoneNumber);
        if (phoneCount!=0) throw new UniquePhoneNumberException("동일 번호는 저장 하실 수 없습니다.");
    }
}
