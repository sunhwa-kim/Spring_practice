package com.sh.adm.repository;

import com.sh.adm.model.entity.Delivery;
import com.sh.adm.model.enumclass.DeliveryStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface DeliveryRepository extends JpaRepository<Delivery, Long> {
    Optional<Delivery> findByDeliveryStatusAndOrderGroupId(Long id, DeliveryStatus deliveryStatus);
}
