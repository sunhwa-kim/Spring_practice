package com.sh.adm.model.entity;

import com.sh.adm.model.enumclass.UserStatus;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Where;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

//@Table(name = "User")   // 동일시 자동 맵핑
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode

@Where(clause = "deleted = false")
@Accessors(chain = true)
@EntityListeners(AuditingEntityListener.class)
@Entity
public class User {

    @Id  // 식별자
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")  // 동일시 자동 맵핑
    private Long id;

    private String account;

    private String password;

    @Enumerated(EnumType.STRING)
    private UserStatus status;

    private String email;

    private String phoneNumber;  // camel case  != snake case(DB)

    private LocalDateTime registeredAt;

    private LocalDateTime unregisteredAt;

    @ColumnDefault("0")
    private boolean deleted;

    @CreatedDate
    private LocalDateTime createdAt;

    @CreatedBy
    private String createdBy;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    @LastModifiedBy
    private String updatedBy;

    @ToString.Exclude
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    private List<OrderGroup> orderGroupList;

    public User(String account, String password, UserStatus status, String email, String phoneNumber) {
        this.account = account;
        this.password = password;
        this.status = status;
        this.email = email;
        this.phoneNumber = phoneNumber;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public void setRegisteredAt(LocalDateTime registeredAt) {
        this.registeredAt = registeredAt;
    }

    public void setUnregisteredAt(LocalDateTime unregisteredAt) {
        this.unregisteredAt = unregisteredAt;
    }

    public void setOrderGroupList(List<OrderGroup> orderGroupList) {
        this.orderGroupList = orderGroupList;
    }

    public void updatedDateAndBy(LocalDateTime updatedAt, String updatedBy) {
        this.updatedAt = updatedAt;
        this.updatedBy = updatedBy;
    }

}
