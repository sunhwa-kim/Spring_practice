package com.sh.adm.ordergroup.model.entity;

import com.sh.adm.exception.NotPermittedChageOrder;
import com.sh.adm.deliverry.entity.Delivery;
import com.sh.adm.common.policy.discount.DiscountPolicy;
import com.sh.adm.orderdetail.entity.OrderDetail;
import com.sh.adm.user.vo.Address;
import com.sh.adm.deliverry.enumclass.DeliveryStatus;
import com.sh.adm.ordergroup.enumclass.OrderStatus;
import com.sh.adm.ordergroup.enumclass.OrderType;
import com.sh.adm.ordergroup.enumclass.PaymentType;
import com.sh.adm.ordergroup.model.dto.OrderGroupApiRequest;
import com.sh.adm.user.model.entity.User;
import lombok.*;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.util.ObjectUtils;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@ToString
@EqualsAndHashCode(of = "id")
@NoArgsConstructor
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
    private BigDecimal discountAmount;
    private BigDecimal discountTotalPrice;

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
    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private Delivery delivery;  // FK

    // private Long userId;
    @ToString.Exclude
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private User user;

    @ToString.Exclude
    @OneToMany(mappedBy = "orderGroup", cascade = CascadeType.ALL)
    private List<OrderDetail> orderDetails = new ArrayList<>();


    /*   양방향 관계 - 연관관계 편의 메서드   */
    public void setUser(User user) {
        this.user = user;
        user.setOrderGroupList(this);
    }

    public void setDelivery(Delivery delivery) {
        this.delivery = delivery;
        delivery.setOrderGroups(this);
    }

    public void setOrderDetails(OrderDetail orderDetail) {
        this.orderDetails.add(orderDetail);
        orderDetail.setOrderGroup(this);
    }

    /*  생성자 메서드   */
    public static OrderGroup createOrderGroup(User user, OrderDetail... orderDetails) {
        OrderGroup orderGroup = new OrderGroup();
        orderGroup.status = OrderStatus.ORDERING;
        orderGroup.setUser(user);
        for (OrderDetail orderDetail : orderDetails) {
            orderGroup.setOrderDetails(orderDetail);
        }
        return orderGroup;
    }

    public void createOrder(Delivery delivery, OrderType orderType, PaymentType paymentType) {
        this.setDelivery(delivery);

        this.status = OrderStatus.CONFIRM;
        this.orderType = orderType;
        this.paymentType = paymentType;
        this.orderAt = LocalDateTime.now();
        this.totalPrice = this.getTotalPrice();
        this.totalQuantity = this.getTotalQuantity();
    }

    public void updateOrder(OrderGroupApiRequest request) {
        if(!ObjectUtils.isEmpty(request.getReceiveName())) this.delivery.setReceiveName(request.getReceiveName());
        if(!(ObjectUtils.isEmpty(request.getCity())||ObjectUtils.isEmpty(request.getStreet())||ObjectUtils.isEmpty(request.getZipcode())))
            this.delivery.setReceiveAddress(Address.of(request.getCity(),request.getStreet(),request.getZipcode()));
    }

    public void cancel() {
        if (!this.delivery.getDeliveryStatus().equals(DeliveryStatus.READY)) throw new NotPermittedChageOrder();
        this.orderDetails.forEach(orderDetail -> {
            orderDetail.cancel();
        });
    }

    public BigDecimal getTotalPrice() {
        return this.orderDetails.stream().map(OrderDetail::getTotalPrice).reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    public int getTotalQuantity() {
        return this.orderDetails.stream().mapToInt(OrderDetail::getQuantity).sum();
    }

    public BigDecimal orderDiscount(DiscountPolicy discountPolicy) {
        this.discountAmount = discountPolicy.discount(this.user, this.totalPrice);
        this.discountTotalPrice = this.totalPrice.subtract(this.discountAmount);
        return this.discountTotalPrice;
    }
}
