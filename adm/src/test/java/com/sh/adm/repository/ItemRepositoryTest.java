package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.model.entity.Category;
import com.sh.adm.model.entity.Item;
import com.sh.adm.model.entity.Partner;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Random;

import static org.assertj.core.api.BDDAssertions.then;

@Transactional
public class ItemRepositoryTest extends AdmApplicationTests {
    private Random random;

    @Autowired
    EntityManager em;
    @Autowired
    ItemRepository itemRepository;

    @Autowired
    CategoryRepository categoryRepository;
    @Autowired
    PartnerRepository partnerRepository;

    @Test
//    @Transactional
    void create() {
        // given
        random = new Random();
        Item item = getItem();
        // when
        Item newItem = itemRepository.save(item);
        em.flush();
        // then
        then(newItem.getName()).isEqualTo(item.getName());
        then(newItem.getPrice()).isEqualTo(item.getPrice());
    }

    @Test
    void 재고_추가_테스트() {

    }

    private Item getItem() {
        Category category = givenCategory();
        categoryRepository.save(category);
        Partner partner = givenPartner(category);
        partnerRepository.save(partner);
        return givenItem(partner);
    }

    private Item givenItem(Partner partner) {
        return Item.builder()
                .status("UNREGISTERED")
                .name("LG 노트북")
                .title("LG 노트북 A100")
                .content("2020년형 노트북")
                .price(BigDecimal.valueOf(900000))
                .brandName("LG")
                .registeredAt(LocalDateTime.now())
                .partner(partner)
                .build();
    }

    private Partner givenPartner(Category category) {
//        Category category = givenCategory();
        String status = "REGISTERED";
        return Partner.builder()
                .name(category.getTitle())
                .status(status)
                .address("서울시 강남구 1번길 1000-100")
                .callCenter("070-1111-1111")
                .partnerNumber("010-1111-1111")
                .businessNumber("123456 2")
                .ceoName("1 대표")
                .registeredAt(getRandomDate())
                .unregisteredAt(status.equals("UNREGISTERED") ? getRandomDate() : null)  // UNREGISTED -> getRandomDate()
                .category(category)
                .build();
    }

    private Category givenCategory() {
        return Category.builder()
                .type("전자제품")
                .title("컴퓨터")
                .build();
    }

    private LocalDateTime getRandomDate(){
        return LocalDateTime.of(2020,getRandomNumber(),getRandomNumber(),getRandomNumber(),getRandomNumber(),getRandomNumber());
    }
    private int getRandomNumber(){
        return random.nextInt(11)+1;
    }
}
