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

    @Embedded
    private Address receiveAddress;

    private String receiveName;

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
    @ManyToOne(fetch = FetchType.LAZY)
    private OrderGroup orderGroups;

    public void setReceiveAddress(Address receiveAddress) {  // 주문 내역 변경 시
        this.receiveAddress = receiveAddress;
    }

    public void setOrderGroups(OrderGroup orderGroup) {
        this.orderGroups = orderGroup;
    }

    public Delivery(Address receiveAddress, String receiveName, OrderGroup orderGroup) {
        this.setOrderGroups(orderGroup);
        this.receiveAddress = receiveAddress;
        this.receiveName = receiveName;
        this.deliveryStatus = DeliveryStatus.READY;
        this.arriveDate = LocalDate.now().plusWeeks(1);
    }


}
