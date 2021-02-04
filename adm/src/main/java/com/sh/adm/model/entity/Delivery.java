package com.sh.adm.model.entity;

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

    public void setOrderGroups(OrderGroup orderGroup) {
        this.orderGroups = orderGroup;
    }

    public Delivery(Address receiveAddress, String receiveName) {
        this.receiveAddress = receiveAddress;   // 기본 사용자 주소
        this.receiveName = receiveName;  // 기본 사용자명
    }
}
