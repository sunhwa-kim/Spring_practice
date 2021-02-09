package com.sh.adm.model.entity;

import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.enumclass.OrderType;
import com.sh.adm.model.enumclass.PaymentType;
import lombok.*;
import org.apache.tomcat.jni.OS;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Entity
public class OrderGroup {

    @Id
    @Column(name="order_group_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private OrderStatus status;

    @Enumerated(EnumType.STRING)
    private OrderType orderType;   // 묶음 , 개별

    @Enumerated(EnumType.STRING)
    private PaymentType paymentType;    // 현금, 카드,.

    private BigDecimal totalPrice;

    private Integer totalQuantity;

    private LocalDateTime orderAt;

    @CreatedDate
    private LocalDateTime createdAt;

    @CreatedBy
    private String createdBy;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    @LastModifiedBy
    private String updatedBy;

    @ToString.Exclude
    @OneToMany(mappedBy = "orderGroups")
    private List<Delivery> delivery = new ArrayList<>();

    // private Long userId;
    @ToString.Exclude
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private User user;

    @ToString.Exclude
    @OneToMany(mappedBy = "orderGroup", cascade = CascadeType.ALL)
    private List<OrderDetail> orderDetails = new ArrayList<>();


    public void setOrderType(OrderType orderType) {
        this.orderType = orderType;
    }

    public void setPaymentType(PaymentType paymentType) {
        this.paymentType = paymentType;
    }

    /*   양방향 관계 - 연관관계 편의 메서드   */
    public void setUser(User user) {
        this.user = user;
        user.setOrderGroupList(this);
    }

    public void setDelivery(Delivery delivery) {
        this.delivery.add(delivery);
        delivery.setOrderGroups(this);
    }

    public void addOrderDetails(OrderDetail orderDetail) {
        this.orderDetails.add(orderDetail);
        orderDetail.setOrderGroup(this);
    }

    /*  생성자 메서드   */
    public static OrderGroup createOrderGroup(User user, OrderDetail... orderDetails) {
        OrderGroup orderGroup = new OrderGroup();
        orderGroup.status = OrderStatus.ORDERING;
        orderGroup.setUser(user);
        for (OrderDetail orderDetail : orderDetails) {
            orderGroup.addOrderDetails(orderDetail);
        }
        return orderGroup;
    }

    public void takeAnOrder(Delivery delivery, List<OrderDetail> orderDetails) {
        this.setDelivery(delivery);

        this.status = OrderStatus.CONFIRM;
        this.orderAt = LocalDateTime.now();
        this.totalPrice = this.getTotalPrice();
        this.totalQuantity = this.getTotalQuantity();
    }

    public void cancelOrderGroup() {
//        this.setDelivery(null);
        this.status = OrderStatus.ORDERING;
        this.orderAt = null;
        this.totalPrice = BigDecimal.ZERO;
        this.totalQuantity = 0;

    }
    public BigDecimal getTotalPrice() {
        return this.orderDetails.stream().map(OrderDetail::getTotalPrice).reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public int getTotalQuantity() {
        return this.orderDetails.stream().mapToInt(OrderDetail::getQuantity).sum();
    }

}
