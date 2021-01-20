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

@Entity
@EntityListeners(AuditingEntityListener.class)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder

@ToString(exclude = {"partner","orderDetailList"})
public class Item {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="item_id")
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
    @ManyToOne
    private Partner partner;

    // Item 1:N OrderDetail
//    @OneToMany(fetch = FetchType.LAZY, mappedBy = "item")
//    private List<OrderDetail> orderDetailList = new ArrayList<>();

    public void addStock(int quantity) {
        this.stockQuantity += quantity;
    }

    public void outStock(int quanity) {
        int checkStock = this.stockQuantity - quanity;
        if (checkStock < 0) {
            throw new NotEnoughStockException("need more");
        }
        this.stockQuantity = checkStock;
    }
}
