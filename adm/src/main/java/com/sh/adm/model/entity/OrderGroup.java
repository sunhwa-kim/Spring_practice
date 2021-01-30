package com.sh.adm.model.entity;

import com.sh.adm.model.enumclass.OrderType;
import lombok.*;
import lombok.experimental.Accessors;
import org.aspectj.weaver.ast.Or;
import org.hibernate.criterion.Order;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
@ToString(exclude = {"orderDetailList","user"})
@Builder
@Accessors(chain = true)

@EntityListeners(AuditingEntityListener.class)
@Entity
public class OrderGroup {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="order_group_id")
    private Long id;

    private String status;

    @Enumerated(EnumType.STRING)
    private OrderType orderType;   // 묶음 , 개별

    private String revAddress;

    private String revName;

    private String paymentType;    // 현금, 카드,.

    private BigDecimal totalPrice;

    private Integer totalQuantity;

    private LocalDateTime orderAt;

    private LocalDate arrivalDate;

    @CreatedDate
    private LocalDateTime createdAt;

    @CreatedBy
    private String createdBy;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    @LastModifiedBy
    private String updatedBy;

    //    private Long userId;
    // OrderGroup N : 1 User
    @ManyToOne(optional = false)
    @JoinColumn(name="user_id")
    private User user;

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "orderGroup",cascade = CascadeType.ALL)
    private List<OrderDetail> orderDetailList = new ArrayList<>();

    public static OrderGroup createOrderGroup(User user, List<OrderDetail> orderDetails) {
        OrderGroup orderGroup = new OrderGroup();
        orderGroup.user = user;
        for (OrderDetail od : orderDetails) {
            orderGroup.orderDetailList.add(od);
            od.setOrderGroup(orderGroup);
        }
        orderGroup.orderGroupTotal();
        return orderGroup;
    }

//        this.orderDetailList = orderDetail;  // no


    public void orderGroupTotal() {
        BigDecimal tempPrice = new BigDecimal(0);
        int tempQuantity = 0;
        for (OrderDetail od : this.orderDetailList) {
            tempPrice = tempPrice.add(od.getTotalPrice());
            tempQuantity += od.getQuantity();
        }
        this.totalPrice = tempPrice;
        this.totalQuantity = tempQuantity;
    }

}
