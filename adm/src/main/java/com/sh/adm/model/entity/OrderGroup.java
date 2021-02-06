package com.sh.adm.model.entity;

import com.sh.adm.model.enumclass.OrderStatus;
import com.sh.adm.model.enumclass.OrderType;
import com.sh.adm.model.enumclass.PaymentType;
import lombok.*;
import lombok.experimental.Accessors;
import org.aspectj.weaver.ast.Or;
import org.hibernate.criterion.Order;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.util.ObjectUtils;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;

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
    @OneToMany(mappedBy = "orderGroup")
    private List<OrderDetail> orderDetails = new ArrayList<>();

    /*   양방향 관계 - 연관관계 편의 메서드   */
    public void setUser(User user) {
        this.user = user;
        user.setOrderGroupList(this);
    }

    public void setDelivery(Delivery delivery) {
        this.delivery.add(delivery);
        delivery.setOrderGroups(this);
    }

    public void setOrderDetails(OrderDetail orderDetail) {
        this.orderDetails.add(orderDetail);
        orderDetail.setOrderGroup(this);
    }

    /*  생성자 메서드   */
    public static OrderGroup initOrderGroup(User user) {
        OrderGroup orderGroup = new OrderGroup();
        orderGroup.setUser(user);
        return orderGroup;
    }
    public static OrderGroup createOrderGroup(User user, OrderDetail orderDetail) {
        OrderGroup orderGroup = new OrderGroup();
        orderGroup.setUser(user);
        orderGroup.setOrderDetails(orderDetail);
        orderGroup.getTotalPrice();
        orderGroup.getTotalQuantity();
        return orderGroup;
    }

    public BigDecimal getTotalPrice() {
/*        BigDecimal prices = new BigDecimal(0);
        for (OrderDetail od : this.orderDetails) {
            prices = prices.add(od.getTotalPrice());
        }
        this.totalPrice = prices;*/

//        BigDecimal colletResult = this.orderDetails.stream().map(OrderDetail::getTotalPrice).reduce(BigDecimal.ZERO, BigDecimal::add);
        return this.orderDetails.stream().map(OrderDetail::getTotalPrice).reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public int getTotalQuantity() {
        return this.orderDetails.stream().mapToInt(OrderDetail::getQuantity).sum();
    }

}
