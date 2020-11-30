package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.Item;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class ItemRepositoryTest extends AdmApplicationTests {
    @Autowired
    ItemRepository itemRepository;

    @Test
//    @Transactional
    public void create() {
        Item item = new Item();
        item.setStatus("UNREGISTERED");
        item.setName("LG 노트북");
        item.setTitle("LG 노트북 A100");
        item.setContent("2020년형 노트북");
        item.setPrice(BigDecimal.valueOf(900000));
        item.setBrandName("LG");
        item.setRegisteredAt(LocalDateTime.now());
        item.setCreatedAt(LocalDateTime.now());
        item.setCreatedBy("AdminServer");

        item.setPartnerId(2L);

        Item newItem = itemRepository.save(item);
        Assertions.assertNotNull(newItem);

    }
}
