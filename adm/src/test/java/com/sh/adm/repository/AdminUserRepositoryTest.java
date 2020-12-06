package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.AdminUser;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;

public class AdminUserRepositoryTest extends AdmApplicationTests {
    @Autowired
    AdminUserRepository adminUserRepository;

    @Test
    public void create() {

        AdminUser adminUser = new AdminUser();
        adminUser.setAccount("AuditorTest1");
        adminUser.setPassword("AuditorTest1");
        adminUser.setStatus("REGISTERED");
        adminUser.setRole("PARTNER");
//        adminUser.setLastLoginAt();   // NULL 허용 건너뛰기
//        adminUser.setPasswordUpdatedAt();
//        adminUser.setLoginFailCount();
//        adminUser.setRegisteredAt();

//        adminUser.setCreatedAt(LocalDateTime.now());    //  -> JPA auditor
//        adminUser.setCreatedBy("AdminServer");


        AdminUser newAdmUser = adminUserRepository.save(adminUser);
        Assertions.assertNotNull(newAdmUser);

    }
}
