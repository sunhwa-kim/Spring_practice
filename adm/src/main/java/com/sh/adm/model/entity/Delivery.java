package com.sh.adm.model.entity;

import com.sh.adm.model.dto.Address;
import com.sh.adm.model.enumclass.DeliveryStatus;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Entity
public class Delivery {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "delivery_id")
    private Long id;

    @Enumerated(EnumType.STRING)
    private DeliveryStatus deliveryStatus;

    private String receiveName;

    @Embedded
    private Address receiveAddress;

    private LocalDate arriveDate;

    @CreatedDate
    private LocalDateTime createdAt;

    @CreatedBy
    private String createdBy;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    @LastModifiedBy
    private String updatedBy;

    @ToString.Exclude
    @OneToOne(mappedBy = "delivery",fetch = FetchType.LAZY)
    private OrderGroup orderGroups;

    public void setReceiveName(String receiveName) {
        this.receiveName = receiveName;
    }

    public void setReceiveAddress(Address receiveAddress) {  // 주문 내역 변경 시
        this.receiveAddress = receiveAddress;
    }

    public void setOrderGroups(OrderGroup orderGroup) {
        this.orderGroups = orderGroup;
    }

    public static Delivery of(Address receiveAddress, String receiveName, OrderGroup orderGroup) {
        Delivery delivery = new Delivery();
        delivery.setOrderGroups(orderGroup);
        delivery.receiveAddress = receiveAddress;
        delivery.receiveName = receiveName;
        delivery.deliveryStatus = DeliveryStatus.READY;
        delivery.arriveDate = LocalDate.now().plusWeeks(1);
        return delivery;
    }


}
