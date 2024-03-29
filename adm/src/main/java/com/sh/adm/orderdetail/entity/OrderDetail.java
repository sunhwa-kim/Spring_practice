package com.sh.adm.orderdetail.entity;

import com.sh.adm.item.entity.Item;
import com.sh.adm.ordergroup.model.entity.OrderGroup;
import com.sh.adm.ordergroup.enumclass.OrderStatus;
import lombok.*;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Entity
public class OrderDetail {

    @Id
    @Column(name = "order_detail_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private OrderStatus status;

    private LocalDate arrivalDate;  // 창고 등 != 사용자

    private Integer quantity;

    private BigDecimal totalPrice;

    @CreatedDate
    private LocalDateTime createdAt;

    @CreatedBy
    private String createdBy;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    @LastModifiedBy
    private String updatedBy;

    //    private Long orderGroupId;
    //      OrderDetail N:1 OrderGroup
    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY)
    private OrderGroup orderGroup;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY)
    private Item item;

    public void setOrderGroup(OrderGroup orderGroup) {
        this.orderGroup = orderGroup;
    }

    public void setItem(Item item) {
        this.item = item;
        item.setOrderDetailList(this);
    }

    /**
     * 기본 주문 생성자 메서드 -> 추가 : 상태, 날짜, 할인
     * @param item
     * @param count
     * @return
     */

//    @Builder  // 2021.02.16
    public static OrderDetail createOrderDetail(Item item, int count) {
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.status = OrderStatus.ORDERING;
        orderDetail.setItem(item);
        orderDetail.quantity = count;
        orderDetail.detailTotalPrice();
        item.outStock(count);
        return orderDetail;
    }

    public void updateOrderDetail(Item item, int quantity) {
        int gap = quantity - this.quantity;
        if(gap > 0){
            item.outStock(gap);
        }
        else if(gap <= 0){
            item.addStock(gap*(-1));
        }
        this.quantity = quantity;
        this.detailTotalPrice();
    }

    public void cancel() {
        this.item.addStock(this.getQuantity());
        this.item.setOrderDetailList(null);
    }

    public void order() {
        this.status = OrderStatus.CONFIRM;
        // TODO 상품 창고 준비 상태 일 때 배송 주소지 별 도착날짜는 Delivery
    }
    public void detailTotalPrice() {
        this.totalPrice = (BigDecimal) this.item.getPrice().multiply(BigDecimal.valueOf(getQuantity()));
    }

}
