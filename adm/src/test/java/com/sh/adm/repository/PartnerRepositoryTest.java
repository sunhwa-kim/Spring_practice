package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.Partner;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;

public class PartnerRepositoryTest extends AdmApplicationTests {

    @Autowired
    PartnerRepository partnerRepository;

    @Test
    public void create() {
        String name = "Partner 02";
        String status = "REGISTERED";
        String address = "서울시 강남구";
        String callCenter = "070-7777-7777";
        String partnerNumber = "010-3333-4444";
        String businessNumber = "123456789012";
        String ceoName = "김선화";
        LocalDateTime registeredAt = LocalDateTime.now();
        LocalDateTime createdAt = LocalDateTime.now();
        String createdBy = "AdminServer";

        Partner partner = new Partner();
        partner.setName(name);
        partner.setStatus(status);
        partner.setAddress(address);
        partner.setCallCenter(callCenter);
        partner.setPartnerNumber(partnerNumber);
        partner.setBusinessNumber(businessNumber);
        partner.setCeoName(ceoName);
        partner.setRegisteredAt(registeredAt);
        partner.setCreatedAt(createdAt);
        partner.setCreatedBy(createdBy);

        Partner newPartner = partnerRepository.save(partner);
        Assertions.assertNotNull(newPartner);
    }
}
