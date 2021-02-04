package com.sh.adm.repository;

import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderGroupRepository extends JpaRepository<OrderGroup,Long> {

}
