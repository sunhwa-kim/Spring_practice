package com.sh.adm.orderdetail.repository;

import com.sh.adm.orderdetail.entity.OrderDetail;
import com.sh.adm.ordergroup.enumclass.OrderStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrderDetailRepository extends JpaRepository<OrderDetail,Long> {

   Optional<OrderDetail> findByOrderGroupIdAndItemId(Long OrderGroupId, Long itemId);  // 카트 내 상품 조회

    List<OrderDetail> findByOrderGroupId(Long id);  // 주문 연관 상품 목록 조회

    List<OrderDetail> findByOrderGroupIdOrderByItemIdAsc(Long id);   // 주문목록 상품 변경시

    Optional<OrderDetail> findByOrderStatusAndItemId(OrderStatus status, Long itemId);
}
