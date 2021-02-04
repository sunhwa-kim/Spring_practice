package com.sh.adm.model.entity;

import com.sh.adm.exception.NotEnoughStockException;
import com.sh.adm.model.enumclass.ItemStatus;
import lombok.*;
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
@EqualsAndHashCode
@ToString
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Entity
public class Item {

    @Id
    @Column(name="item_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private ItemStatus status;  // READY, REGISTERED

    private String name;

    private String title;

    private String content;

    private BigDecimal price;

    private int stockQuantity;

    private String brandName;

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

    //    private Long partnerId;
    // Partner 1: N Item
    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY)
    private Partner partner;

    // Item 1:N OrderDetail
    @ToString.Exclude
    @OneToMany(mappedBy = "item", cascade = CascadeType.ALL)
    private List<OrderDetail> orderDetailList = new ArrayList<>();

    public void setPartner(Partner partner) {
        this.partner = partner;
        partner.setItem(this);
    }

    @Builder
    public Item(ItemStatus status, String name, String title, String content, BigDecimal price, int stockQuantity, String brandName, LocalDateTime registeredAt, Partner partner) {
        this.status = status;
        this.name = name;
        this.title = title;
        this.content = content;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.brandName = brandName;
        this.registeredAt = registeredAt;
        this.setPartner(partner);
    }

    public void addStock(int quantity) {
        this.stockQuantity += quantity;
    }

    public void outStock(int quanity) {
        int checkStock = this.stockQuantity - quanity;
        if (checkStock < 0) {
            throw new NotEnoughStockException(this.getName()+ " need more" );
        }
        this.stockQuantity = checkStock;
    }
}
