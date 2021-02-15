package sh.mycontact_info.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import sh.mycontact_info.domain.entity.Person;

import java.util.List;

public interface PersonRepository extends JpaRepository<Person,Long> {

    Long countByName(String name);

    Long countByPhoneNumber(String phoneNumber);

//    List<Person> findByPhoneNumber(String phoneNumber);

    @Query("select person from Person person where person.birthday.monthOfBirthday = :monthOfBirthday")
    List<Person> findMonthOfBirthday(@Param("monthOfBirthday") int monthOfBirthday);

    @Query(value = "select * from person p where p.deleted = true",nativeQuery = true)
    List<Person> findPeopleDeleted();
}
