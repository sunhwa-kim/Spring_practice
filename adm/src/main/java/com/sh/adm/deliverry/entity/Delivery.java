package com.sh.adm.deliverry.entity;

import com.sh.adm.ordergroup.entity.OrderGroup;
import com.sh.adm.user.vo.Address;
import com.sh.adm.deliverry.enumclass.DeliveryStatus;
import com.sh.adm.ordergroup.dto.OrderGroupApiRequest;
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
    private OrderGroup orderGroup;

    public void setReceiveName(String receiveName) {
        this.receiveName = receiveName;
    }

    public void setReceiveAddress(Address receiveAddress) {  // 주문 내역 변경 시
        this.receiveAddress = receiveAddress;
    }

    public void setOrderGroups(OrderGroup orderGroup) {
        this.orderGroup = orderGroup;
    }

    public static Delivery of(OrderGroupApiRequest body) {
        Delivery delivery = new Delivery();
        Address address = Address.of(body.getCity(), body.getStreet(), body.getZipcode());
        // 주문 내역 정리
            // orderGroup이 delievery 가져서, delivery가 ordergorup을 알 필요 없다?
        // 배달 정보
        delivery.receiveAddress = address;
        delivery.receiveName = body.getReceiveName();
        delivery.deliveryStatus = DeliveryStatus.READY;
        delivery.arriveDate = LocalDate.now().plusWeeks(1);  // default 배달 1주 쇼요
        return delivery;
    }


}
