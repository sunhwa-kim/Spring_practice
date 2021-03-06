package com.sh.adm.repository;

import com.sh.adm.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

//    User findFirstByStatusOrderByIdDesc(String status);

    List<User> findByAccount(String account);

    Optional<User> findFirstByPhoneNumberOrderByIdDesc(String phoneNumber);

    @Query(value = "select * from User user where user.deleted = true",nativeQuery = true)
    List<User> findUserDeleted();

    @Query(value = "select user from User user where user.birthday.monthOfBirthday = :monthOfBirthday")
    List<User> findByMonthOfBirthday(@Param("monthOfBirthday") int monthOfBirthday);
}
