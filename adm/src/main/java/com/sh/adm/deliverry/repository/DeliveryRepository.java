package com.sh.adm.deliverry.repository;

import com.sh.adm.deliverry.entity.Delivery;
import com.sh.adm.deliverry.enumclass.DeliveryStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface DeliveryRepository extends JpaRepository<Delivery, Long> {
    Optional<Delivery> findByDeliveryStatusAndOrderGroupId(Long id, DeliveryStatus deliveryStatus);
}
