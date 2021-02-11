package com.sh.adm.repository;

import com.sh.adm.model.entity.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

public interface OrderDetailRepository extends JpaRepository<OrderDetail,Long> {

    Optional<OrderDetail> findByOrderGroupIdAndItemId(Long OrderGroupId, Long itemId);

    List<OrderDetail> findByOrderGroupIdOrderByCreatedAtDesc(Long id);

    List<OrderDetail> findByOrderGroupIdOrderByItemIdAsc(Long id);
}
