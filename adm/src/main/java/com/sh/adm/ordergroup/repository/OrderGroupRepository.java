package com.sh.adm.ordergroup.repository;

import com.sh.adm.ordergroup.model.entity.OrderGroup;
import com.sh.adm.ordergroup.enumclass.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderGroupRepository extends JpaRepository<OrderGroup,Long> {
    
    // ORDERING : 현재 사용중인 장바구니,  COMPLETE : 지난 주문 내역 조회
    List<OrderGroup> findByStatusAndUserId(OrderStatus orderStatus, Long UserId);
}
