package com.sh.adm.repository;

import com.sh.adm.model.entity.Partner;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

public interface PartnerRepository extends JpaRepository<Partner,Long> {
}
