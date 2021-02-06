package com.sh.adm.repository;

import com.sh.adm.model.entity.OrderGroup;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

public interface OrderGroupRepository extends JpaRepository<OrderGroup,Long> {
    
    // ORDERING : 현재 사용중인 장바구니,  COMPLETE : 지난 주문 내역 조회
    List<OrderGroup> findByStatusAndUserId(OrderStatus orderStatus, Long UserId);
}
