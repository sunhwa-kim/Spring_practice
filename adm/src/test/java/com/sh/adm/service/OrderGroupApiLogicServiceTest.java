package com.sh.adm.service;

import com.sh.adm.AdmApplicationTests;
import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.entity.*;
import com.sh.adm.model.enumclass.ItemStatus;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.OrderGroupApiRequest;
import com.sh.adm.model.network.response.OrderGroupApiResponse;
import com.sh.adm.repository.ItemRepository;
import com.sh.adm.repository.OrderDetailRepository;
import com.sh.adm.repository.OrderGroupRepository;
import com.sh.adm.repository.UserRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;

import static com.sh.adm.model.entity.OrderDetail.createOrderDetail;
import static org.assertj.core.api.BDDAssertions.then;


@Transactional
public class OrderGroupApiLogicServiceTest extends AdmApplicationTests implements CrudInterface<OrderGroupApiRequest, OrderGroupApiResponse> {
    Random random;

    @Autowired
    OrderGroupRepository orderGroupRepository;
    @Autowired
    OrderDetailRepository orderDetailRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    ItemRepository itemRepository;

    @Test
    void orderServiceTest() {
        // given : 사용자가 고른 item 주문
        int testPrice = 900000;
        int testPrice2 = 140000;
        int item1OriginConut = 10;
        int item2OriginCount = 10;
        int item1Count = 2;
        int item2Count = 1;
        int testResult1 = (testPrice * item1Count) + (testPrice2 * item2Count);

        random = new Random();
        User user = givenUserInfo();
        userRepository.save(user);
        Item item1 = getItem("LG 노트북", "LG 노트북 A100", testPrice, item1OriginConut);
        Item item2 = getItem("FC750R", "LEOPOLD", testPrice2, item2OriginCount);
//        int seletedItemCount = 2;    // for another case
        itemRepository.save(item1);
        itemRepository.save(item2);

        // when
        List<OrderDetail> orderDetailList = new ArrayList<>();
         // 주문 요청 : item_id + 수량, 사용자 (data in request) -> entity 조회
        itemRepository.findById(item1.getId());   // requst 받아온 item_id로 조회
        itemRepository.findById(item2.getId());
        // 주문 상품
        /**
         * item 별 주문 수량 : OrderDetail
         *  item 가진 OrderDetail 생성 -> OrderGroup 생성
         */
        orderDetailList.add(OrderDetail.createOrderDetail(item1, item1Count));
        orderDetailList.add(OrderDetail.createOrderDetail(item2, item2Count));
        // 주문
        OrderGroup orderGroup = OrderGroup.createOrderGroup(user, orderDetailList);
        OrderGroup testOg = orderGroupRepository.save(orderGroup);

        Optional<Item> item1Id = itemRepository.findById(item1.getId());
        Optional<OrderDetail> orderDetailId = orderDetailRepository.findById(1L);
        then(testOg.getTotalPrice().intValue()).isEqualTo(testResult1);
        then(testOg.getTotalQuantity()).isEqualTo(item1Count + item2Count);
        then(item1Id.get().getStockQuantity()).isEqualTo(item1OriginConut - item1Count);
        then(orderDetailId.get().getItem().getName()).isEqualTo(item1.getName());
    }


    @Override
    @Test
    public Header<OrderGroupApiResponse> create(Header<OrderGroupApiRequest> request) {
        OrderGroupApiRequest body = request.getData();   // Optional
        if (body != null) {
            OrderGroup newOG = orderGroupRepository.save(givenOrder(body));
            return response(newOG);
        }
        return Header.error("No data exsited");
    }

    @Override
    @Test
    public Header<OrderGroupApiResponse> read(Long id) {
        // 목록 중 클릭된 row의 id 받아서 상세 정보 제공

        return orderGroupRepository.findById(id)
                .map(this::response)
                .orElseGet(() -> Header.error("No data existed"));
    }

    @Override
    @Test
    public Header<OrderGroupApiResponse> update(Header<OrderGroupApiRequest> request) {
        // 상세정보에서 수정 -> id로 DB data -> upated -> response
        OrderGroupApiRequest body = request.getData();
        return orderGroupRepository.findById(body.getId())
                .map(entity -> {
                    entity.setStatus(body.getStatus())
                            .setOrderType(body.getOrderType())
                            .setRevAddress(body.getRevAddress())
                            .setRevName(body.getRevName())
                            .setPaymentType(body.getPaymentType())
                            .setTotalPrice(body.getTotalPrice())
                            .setTotalQuantity(body.getTotalQuantity())
                            .setOrderAt(body.getOrderAt())
                            .setArrivalDate(body.getArrivalDate())
                            .setUser(userRepository.getOne(body.getId()));
                    return entity;
                }).map(this::response)
                .orElseGet(() -> Header.error("No data existed"));
    }

    @Override
    @Test
    public Header delete(Long id) {
        return orderGroupRepository.findById(id)
                .map(entity -> {
                    orderGroupRepository.delete(entity);
                    return Header.OK();
                }).orElseGet(() -> Header.error("No data existed"));
    }

    private Header<OrderGroupApiResponse> response(OrderGroup og){
        OrderGroupApiResponse body = OrderGroupApiResponse.builder()
                .status(og.getStatus())
                .orderType(og.getOrderType())
                .revAddress(og.getRevAddress())
                .revName(og.getRevName())
                .paymentType(og.getPaymentType())
                .totalPrice(og.getTotalPrice())
                .totalQuantity(og.getTotalQuantity())
                .orderAt(og.getOrderAt())
                .arrivalDate(og.getArrivalDate())
                .build();

        return Header.OK(body);
    }

    private OrderGroup givenOrder(OrderGroupApiRequest body){
        return OrderGroup.builder()
                .status(body.getStatus())
                .orderType(body.getOrderType())
                .revAddress(body.getRevAddress())
                .revName(body.getRevName())
                .paymentType(body.getPaymentType())
                .totalPrice(body.getTotalPrice())
                .totalQuantity(body.getTotalQuantity())
                .orderAt(LocalDateTime.now())
                .user(userRepository.getOne(body.getUserId()))   // 실제는 받지 않음
                .build();
    }


    private User givenUserInfo() {
        return new User("test01", "pwd01", UserStatus.REGISTERED,"email@gmail.com" ,"010-1111-2222");

    }

    private Item getItem(String name, String title, int price, int quantity) {
        random = new Random();
        Category category = givenCategory();
        Partner partner = givenPartner(category);
        return givenItem(partner,name,title,price,quantity);
    }

    private Item givenItem(Partner partner,String name,String title, int price,int quantity) {
        return Item.builder()
                .status(ItemStatus.UNREGISTERED)
                .name(name)
                .title(title)
                .content("2020년형")
                .price(BigDecimal.valueOf(price))
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
