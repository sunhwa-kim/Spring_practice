package com.sh.adm.user.repository;

import com.sh.adm.user.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {

//    User findFirstByStatusOrderByIdDesc(String status);

    Boolean existsByAccount(String account);

    Optional<User> findByAccount(String account);

    @Query(value = "select * from User user where user.deleted = true",nativeQuery = true)
    List<User> findUserDeleted();

    @Query(value = "select user from User user where user.birthday.monthOfBirthday = :monthOfBirthday")
    List<User> findByMonthOfBirthday(@Param("monthOfBirthday") int monthOfBirthday);
}
