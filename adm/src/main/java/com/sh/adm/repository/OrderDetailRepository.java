package com.sh.adm.repository;

import com.sh.adm.model.entity.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

public interface OrderDetailRepository extends JpaRepository<OrderDetail,Long> {

    Optional<OrderDetail> findByItemIdAndOrderGroupId(Long itemId, Long OrderGroupId);
}
