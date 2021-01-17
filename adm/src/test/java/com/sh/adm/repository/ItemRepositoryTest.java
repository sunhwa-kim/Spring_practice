package com.sh.adm.repository;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.exception.NotEnoughStockException;
import com.sh.adm.model.entity.Category;
import com.sh.adm.model.entity.Item;
import com.sh.adm.model.entity.Partner;
import com.sh.adm.model.enumclass.ItemStatus;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.EntityManager;
import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Random;

import static org.assertj.core.api.Assertions.assertThatExceptionOfType;
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
        int inputQuantity = 10;
        Item item = getItem(inputQuantity);
        // when
        Item newItem = itemRepository.save(item);
        em.flush();
        // then
        then(newItem.getName()).isEqualTo(item.getName());
        then(newItem.getPrice()).isEqualTo(item.getPrice());
        then(newItem.getStockQuantity()).isEqualTo(inputQuantity);
        then(newItem.getStatus()).isEqualTo(ItemStatus.UNREGISTERED);  // default
    }

    @Test
    void 재고_추가_테스트() {
        // given
        int quantity = 0;
        int test = 10;
        Item item = getItem(quantity); // 10
        //when
        item.addStock(test);
        Item getItem = itemRepository.save(item);
        em.flush();
        //then
        then(getItem.getStockQuantity()).isEqualTo(test);
    }

    @Test
    void notEnoughStockExceptionTest() {
        Item item = getItem(0);
        if (item.getStockQuantity() <= 0) {  // -> outStock : 주문시
            assertThatExceptionOfType(NotEnoughStockException.class).isThrownBy(() -> {
                throw new NotEnoughStockException("need more!");
            }).withMessage("%s!", "need more").withMessageContaining("need").withNoCause();
        } else {
            item.setStockQuantity(item.getStockQuantity() - 1);
        }
        // 저장은 repository 별도...
    }

    @Test
    void 제고_품절_예외() {
        // given
        int stockTest = 0;
        int test = 1;
        Item item = itemRepository.save(getItem(stockTest));  // default stock is zero
        //when
        assertThatExceptionOfType(NotEnoughStockException.class).isThrownBy(() -> {
            item.outStock(test);
        }).withMessage("need more");
    }

    private Item getItem(int quantity) {
        random = new Random();
        Category category = givenCategory();
        categoryRepository.save(category);
        Partner partner = givenPartner(category);
        partnerRepository.save(partner);
        return givenItem(partner, quantity);
    }

    private Item givenItem(Partner partner, int quantity) {
        return Item.builder()
                .status(ItemStatus.UNREGISTERED)
                .name("LG 노트북")
                .title("LG 노트북 A100")
                .content("2020년형 노트북")
                .price(BigDecimal.valueOf(900000))
                .stockQuantity(quantity)
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
