package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.category.entity.Category;
import com.sh.adm.category.repository.CategoryRepository;
import com.sh.adm.partner.entity.Partner;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;

public class CategoryRepositoryTest extends AdmApplicationTests {
    @Autowired
    CategoryRepository categoryRepository;

    @Test
    public void create() {
        LocalDateTime createAt = LocalDateTime.now();
        String createdBy = "AdminServer";
        String title = "자동차";
        String type = "car";

        Partner partner = givenPartner();
        Category category = new Category(title, type);
        Category newCategory = categoryRepository.save(category);
        Assertions.assertNotNull(newCategory);
    }

    private Partner givenPartner() {
        String status = "REGISTERED";
        return Partner.builder()
                .name("파트너사")
                .status(status)
                .address("서울시 강남구 1번길 1000-100")
                .callCenter("070-1111-1111")
                .partnerNumber("010-1111-1111")
                .businessNumber("123456 2")
                .ceoName("1 대표")
                .registeredAt(LocalDateTime.now())
                .build();
    }

    private Category givenCategory() {
        return new Category("전자제품","컴퓨터");
    }
}
