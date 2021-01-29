package sh.mycontact_info.repository;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;
import sh.mycontact_info.domain.Address;
import sh.mycontact_info.domain.Birthday;
import sh.mycontact_info.domain.entity.Person;

import java.time.LocalDate;
import java.util.List;

import static org.assertj.core.api.BDDAssertions.then;
import static org.junit.jupiter.api.Assertions.assertAll;

@Transactional
@SpringBootTest
class PersonRepositoryTest {

    @Autowired
    private PersonRepository personRepository;

    @Test
    void create() {
        Person person = givenPerson("testName", "010-1111-1111",Address.of("city","street","zip") ,LocalDate.of(2000, 1, 1));
        personRepository.save(person);
        Person getPerson = personRepository.findById(1L).get();
        assertAll(
                () ->  then(getPerson.getName()).isEqualTo("testName"),
                () ->  then(getPerson.getPhoneNumber()).isEqualTo("010-1111-1111"),
                () ->  then(getPerson.getAddress()).isEqualTo(Address.of("city","street","zip")),
                () ->  then(getPerson.getBirthday()).isEqualTo(Birthday.of(LocalDate.of(2000,1,1))),
                () -> then(getPerson.isDeleted()).isFalse()
        );
    }

    @Test
    void findPhoneNumberTest() {
        String testPhoneNumber = "010-1111-1111";
        Person person = givenPerson("testName1",testPhoneNumber ,Address.of("city","street","zip") ,LocalDate.of(2000, 1, 1));
        Person person1 = givenPerson("testName2", testPhoneNumber,Address.of("city2","street2","zip2") ,LocalDate.of(2000, 2, 2));
        personRepository.save(person);
        personRepository.save(person1);

        List<Person> getList = personRepository.findByPhoneNumber("010-1111-1111");
//        List<Member> getList = memberRepository.findByNameAndPhoneNumberContaining("testName2", "010-1111-1111");

        then(getList.size()).isEqualTo(2);
        then(getList.get(0).getPhoneNumber()).isEqualTo(testPhoneNumber);
        then(getList.get(1).getPhoneNumber()).isEqualTo(testPhoneNumber);
    }

    @Test
    void findDeletedMembers() {
        Person person1 = givenPerson("testName1","010-1111-1111" ,Address.of("city","street","zip") ,LocalDate.of(2000, 1, 1));
        Person person2 = givenPerson("testName2","010-2222-2222" ,Address.of("city","street","zip") ,LocalDate.of(2000, 1, 1));
        Person person3 = givenPerson("testName3","010-3333-3333" ,Address.of("city","street","zip") ,LocalDate.of(2001, 2, 2));

        personRepository.save(person1);
        personRepository.save(person3);
        personRepository.save(person2);
        person1.setDeleted(true);
        person2.setDeleted(true);

        List<Person> peopleDeleted = personRepository.findPeopleDeleted();
        assertAll(
                () -> then(peopleDeleted.size()).isEqualTo(2),
                () -> then(peopleDeleted.get(0).getName()).isEqualTo("testName1"),
                () -> then(peopleDeleted.get(1).getName()).isEqualTo("testName2"),
                () -> then(peopleDeleted.get(0).getPhoneNumber()).isEqualTo("010-1111-1111"),
                () -> then(peopleDeleted.get(1).getPhoneNumber()).isEqualTo("010-2222-2222"),
                () -> then(peopleDeleted.get(0).getBirthday()).isNotNull(),
                () -> then(peopleDeleted.get(1).getBirthday()).isNotNull(),
                () -> then(peopleDeleted.get(0).getAddress()).isEqualTo(Address.of("city","street","zip")),
                () -> then(peopleDeleted.get(0).isDeleted()).isTrue(),
                () -> then(peopleDeleted.get(1).isDeleted()).isTrue()
        );
    }

    @Test
    void findBirthdayOfMonth() {
        Person person1 = givenPerson("testName1","010-1111-1111" ,Address.of("city","street","zip") ,LocalDate.of(2000, 1, 1));
        Person person2 = givenPerson("testName2","010-2222-2222" ,Address.of("city","street","zip") ,LocalDate.of(2000, 1, 1));
        Person person3 = givenPerson("testName3","010-3333-3333" ,Address.of("city","street","zip") ,LocalDate.of(2001, 2, 2));

        personRepository.save(person1);
        personRepository.save(person3);
        personRepository.save(person2);

        List<Person> monthOfBirthday = personRepository.findMonthOfBirthday(1);
        assertAll(
                () -> then(monthOfBirthday.size()).isEqualTo(2),
                () -> then(monthOfBirthday.get(0).getName()).isEqualTo("testName1"),
                () -> then(monthOfBirthday.get(1).getName()).isEqualTo("testName2"),
                () -> then(monthOfBirthday.get(0).getPhoneNumber()).isEqualTo("010-1111-1111"),
                () -> then(monthOfBirthday.get(1).getPhoneNumber()).isEqualTo("010-2222-2222" ),
                () -> then(monthOfBirthday.get(0).getBirthday()).isEqualTo(Birthday.of(LocalDate.of(2000, 1, 1))),
                () -> then(monthOfBirthday.get(1).getBirthday()).isEqualTo(Birthday.of(LocalDate.of(2000, 1, 1))),
                () -> then(monthOfBirthday.get(0).isDeleted()).isFalse(),
                () -> then(monthOfBirthday.get(1).isDeleted()).isFalse()
        );
    }

    private Person givenPerson(String name, String phone, Address address, LocalDate birthday) {
        return new Person(name, phone,address, Birthday.of(birthday));
    }
}