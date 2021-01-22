package com.sh.adm.model.entity;

import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.criterion.Order;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@EntityListeners(AuditingEntityListener.class)
@Data
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@Builder

@ToString(exclude = {"item","orderGroup"})
public class OrderDetail {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_detail_id")
    private Long id;

    private String status;

    private LocalDateTime arrivalDate;

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
    // OrderDetail N:1 OrderGroup
    @ManyToOne(fetch = FetchType.LAZY)
    private OrderGroup orderGroup;
    //    private Long itemId;
//   OrderDetail N:1 Item
    @ManyToOne(fetch = FetchType.LAZY)
    private Item item;

    /**
     * 기본 주문 생성자 메서드 -> 추가 : 상태, 날짜, 할인
     * @param item
     * @param count
     * @return
     */
    public static OrderDetail createOrderDetail(Item item, int count) {
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setItem(item);
        orderDetail.setQuantity(count);
        orderDetail.detailTotalPrice();
        item.outStock(count);
        return orderDetail;
    }

    public void detailTotalPrice() {
        this.totalPrice = (BigDecimal) this.item.getPrice().multiply(BigDecimal.valueOf(getQuantity()));
    }

}
