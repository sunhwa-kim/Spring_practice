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

    /**
     * 기본 주문 생성자 메서드 -> 추가 : 상태, 날짜, 할인
     * @param item
     * @param count
     * @return
     */
    public static OrderDetail createOrderDetail(Item item, int count) {
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.item = item;
        orderDetail.quantity = count;
        orderDetail.detailTotalPrice();
        item.outStock(count);
        return orderDetail;
    }

    public void updateOrderDetail(Item item, int increasedQuantity) {
        int difference = 0;
        if( this.quantity != increasedQuantity ) {
            difference = Math.abs(increasedQuantity - this.quantity);
            this.quantity += difference;
            this.detailTotalPrice();
            item.outStock(difference);
        }
    }

    public void detailTotalPrice() {
        this.totalPrice = (BigDecimal) this.item.getPrice().multiply(BigDecimal.valueOf(getQuantity()));
    }

}
