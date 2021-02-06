package com.sh.adm.model.entity;

import lombok.*;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Getter
@EqualsAndHashCode
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Entity
public class Partner {
    @Id
    @Column(name = "partner_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String status;

    private String address;

    private String callCenter;

    private String partnerNumber;

    private String businessNumber;

    private String ceoName;

    private LocalDateTime registeredAt;

    private LocalDateTime unregisteredAt;

    @CreatedDate
    private LocalDateTime createdAt;

    @CreatedBy
    private String createdBy;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    @LastModifiedBy
    private String updatedBy;

    //    private Long categoryId;
    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY)
    private Category category;

    // Partner 1: N Item
    @ToString.Exclude
    @OneToMany(mappedBy = "partner", cascade = CascadeType.ALL)
    private List<Item> itemList = new ArrayList<>();

    public void setCategory(Category category) {
        this.category = category;
        category.setPartner(this);
    }

    public void setItem(Item item) {
        this.itemList.add(item);
    }

    @Builder
    public Partner(String name, String status, String address, String callCenter, String partnerNumber, String businessNumber, String ceoName, LocalDateTime registeredAt, Category category) {
        this.name = name;
        this.status = status;
        this.address = address;
        this.callCenter = callCenter;
        this.partnerNumber = partnerNumber;
        this.businessNumber = businessNumber;
        this.ceoName = ceoName;
        this.registeredAt = registeredAt;
        this.setCategory(category);
    }
}
