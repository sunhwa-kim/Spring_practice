package com.sh.adm.repository;

import com.sh.adm.model.entity.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

public interface OrderDetailRepository extends JpaRepository<OrderDetail,Long> {

    Optional<OrderDetail> findByOrderGroupIdAndItemId(Long OrderGroupId, Long itemId);  // 카트 내 상품 조회

    List<OrderDetail> findByOrderGroupIdOrderByCreatedAtDesc(Long id);  // 주문 연관 상품 목록 조회

    List<OrderDetail> findByOrderGroupIdOrderByItemIdAsc(Long id);   // 주문목록 상품 변경시
}
