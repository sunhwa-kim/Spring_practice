package com.sh.adm.repository;

import com.sh.adm.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository  extends JpaRepository<User, Long> {

//    User findFirstByStatusOrderByIdDesc(String status);

    Optional<User> findFirstByPhoneNumberOrderByIdDesc(String phoneNumber);
}
