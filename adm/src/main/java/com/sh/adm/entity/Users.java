package com.sh.adm.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
//@Table(name = "User")   // 동일시 자동 맵핑
@Getter
@Setter
public class Users {

    @Id  // 식별자
    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    @Column(name = "id")  // 동일시 자동 맵핑
    private Long id;

    private String account;

   /*
     public String getAccount() {
        return account;
    }
    public void setAccount(String account) {
        this.account = account;
    }
    */

    private String email;

    private String phoneNumber;  // camel case  != snake case(DB)

    private LocalDateTime createdAt;

    private String createdBy;

    private LocalDateTime updatedAt;

    private  String updatedBy;
}
