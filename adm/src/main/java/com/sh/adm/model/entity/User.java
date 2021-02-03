package com.sh.adm.model.entity;

import com.sh.adm.model.dto.Birthday;
import com.sh.adm.model.entity.coupon.Coupon;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.request.UserApiRequest;
import lombok.*;
import lombok.experimental.Accessors;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Where;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;
import org.springframework.util.ObjectUtils;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

//@Table(name = "User")   // 동일시 자동 맵핑
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@EqualsAndHashCode
@Accessors(chain = true)
@EntityListeners(AuditingEntityListener.class)
@Where(clause = "deleted = false")
@Entity
public class User {

    @Id  // 식별자
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")  // 동일시 자동 맵핑
    private Long id;


    @NotBlank
    private String account;

    @NotBlank
    private String password;

    @Enumerated(EnumType.STRING)
    private UserStatus status;

    private String email;

    @NotBlank
    private String phoneNumber;  // camel case  != snake case(DB)

    @Embedded
    private Birthday birthday;

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
    @OneToMany(mappedBy = "user")
    private List<OrderGroup> orderGroupList;

    @ToString.Exclude
    @OneToMany(mappedBy = "users")
    private List<Coupon> coupons;

    public User(String account, String password, UserStatus status, String email, String phoneNumber,LocalDate birthday ,LocalDateTime registeredAt) {
        this.account = account;
        this.password = password;
        this.status = status;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.birthday = Birthday.of(birthday);
        this.registeredAt = registeredAt;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public void setOrderGroupList(List<OrderGroup> orderGroupList) {
        this.orderGroupList = orderGroupList;
    }

    public void deledtedAccount(LocalDateTime unregisteredAt, UserStatus status, boolean deleted) {
        this.unregisteredAt = unregisteredAt;
        this.status = status;
        this.deleted = deleted;
    }

    public void userUpdate(UserApiRequest request) {
        if( !ObjectUtils.isEmpty(request.getStatus()) ) this.status = request.getStatus();
        if( request.getBirthday() != null) this.birthday = Birthday.of(request.getBirthday());  // data type casting
    }

}
