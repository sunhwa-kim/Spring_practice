package com.sh.adm.repository;

import com.sh.adm.model.entity.Users;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository  extends JpaRepository<Users, Long> {
}
