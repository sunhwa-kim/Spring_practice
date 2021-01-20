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

        AdminUser adminUser = AdminUser.builder()
                .account("Builder01")
                .password("Builder01")
                .status("REGISTERED")
                .role("PARTNER")
                .build();

        //@Accessors(chain = true)
        // chain constructor -> using modify
//        AdminUser user = new AdminUser().setAccount("").setPassword("").setStatus("").setRole();


//        AdminUser adminUser = new AdminUser();    // -> Builder
//        adminUser.setAccount("AuditorTest1");
//        adminUser.setPassword("AuditorTest1");
//        adminUser.setStatus("REGISTERED");
//        adminUser.setRole("PARTNER");
//        adminUser.setLastLoginAt();   // NULL 허용 건너뛰기
//        adminUser.setPasswordUpdatedAt();
//        adminUser.setLoginFailCount();
//        adminUser.setRegisteredAt();

//        adminUser.setCreatedAt(LocalDateTime.now());    //  -> JPA auditor
//        adminUser.setCreatedBy("AdminServer");


        AdminUser newAdmUser = adminUserRepository.save(adminUser);
        Assertions.assertNotNull(newAdmUser);

    }

    @Test
    public void update(){
        // from entity : @Accessors(chain = true)
        adminUserRepository.findById(14L)
                .ifPresent(adminUser -> {
                    adminUser.setAccount("ch_chain")
                            .setPassword("changed");
                    adminUserRepository.save(adminUser);
                });

        adminUserRepository.findById(14L)
                .ifPresent(adminUser -> {
                    Assertions.assertEquals(adminUser.getAccount(),"ch_chain");
                });
    }
}
