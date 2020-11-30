package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.Category;
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

        Category category = new Category();
        category.setTitle(title);
        category.setType(type);
        category.setCreatedAt(createAt);
        category.setCreatedBy(createdBy);

        Category newCategory = categoryRepository.save(category);
        Assertions.assertNotNull(newCategory);
    }

}
