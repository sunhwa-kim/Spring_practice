package sh.mycontact_info.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import sh.mycontact_info.domain.entity.Person;

import java.util.List;


public interface PersonRepository extends JpaRepository<Person,Long> {

    List<Person> findByPhoneNumber(String phoneNumber);

    @Query(value = "select * from person p where p.deleted = true",nativeQuery = true)
    List<Person> findPeopleDeleted();
}
