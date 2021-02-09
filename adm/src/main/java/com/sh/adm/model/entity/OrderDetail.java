package com.sh.adm.model.entity;

import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.network.request.OrderDetailApiRequest;
import lombok.*;
import org.hibernate.annotations.Fetch;
import org.hibernate.criterion.Order;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.util.ObjectUtils;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Getter
@ToString
@EqualsAndHashCode
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Entity
public class OrderDetail {

    @Id
    @Column(name = "order_detail_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private OrderStatus status;

    private LocalDateTime arrivalDate;  // 창고 등 != 사용자

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

    //    private Long itemId;
    //   OrderDetail N:1 Item
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
    public static OrderDetail createOrderDetail(Item item, int count) {
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setItem(item);
        orderDetail.quantity = count;
        orderDetail.detailTotalPrice();
        item.outStock(count);
        return orderDetail;
    }

    public void updateOrderDetail(Item item, int quantity) {
        if( this.quantity != quantity ) {
            int difference = Math.abs(quantity - this.quantity);
            this.quantity = quantity;
            this.detailTotalPrice();
            if( difference < 0 ) item.addStock(difference);
            else item.outStock(difference);
        }
    }

    public void cancelOrder() {
        this.item.addStock(this.getQuantity());
    }

    public void detailTotalPrice() {
        this.totalPrice = (BigDecimal) this.item.getPrice().multiply(BigDecimal.valueOf(getQuantity()));
    }

}
