package com.sh.adm.model.entity;

import com.sh.adm.model.enumclass.UserStatus;
import lombok.*;
import lombok.experimental.Accessors;
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
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString

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

    @Builder
    public User(String account, String password, UserStatus status, String email, String phoneNumber, LocalDateTime registeredAt, LocalDateTime unregisteredAt, List<OrderGroup> orderGroupList) {
        this.account = account;
        this.password = password;
        this.status = status;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.registeredAt = registeredAt;
        this.unregisteredAt = unregisteredAt;
        this.orderGroupList = orderGroupList;
    }
}
   /*
     public String getAccount() {
        return account;
    }
    public void setAccount(String account) {
        this.account = account;
    }
    */