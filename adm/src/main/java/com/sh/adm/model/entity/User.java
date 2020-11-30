package com.sh.adm.model.entity;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
//@Table(name = "User")   // 동일시 자동 맵핑
@Getter
@Setter
@Data
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

    private LocalDateTime createdAt;

    private String createdBy;

    private LocalDateTime updatedAt;

    private  String updatedBy;
}
   /*
     public String getAccount() {
        return account;
    }
    public void setAccount(String account) {
        this.account = account;
    }
    */