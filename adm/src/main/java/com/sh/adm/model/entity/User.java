package com.sh.adm.model.entity;

import lombok.*;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
//@Table(name = "User")   // 동일시 자동 맵핑
@EntityListeners(AuditingEntityListener.class)
//@Getter
//@Setter
@Data
@Builder

@ToString(exclude = {"orderGroupList"})
public class User {

    @Id  // 식별자
    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @Column(name = "id")  // 동일시 자동 맵핑
    private Long id;

    private String account;

    private String password;

    private String status;

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

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
    private List<OrderGroup> orderGroupList;
}
   /*
     public String getAccount() {
        return account;
    }
    public void setAccount(String account) {
        this.account = account;
    }
    */