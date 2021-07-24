package com.sh.adm.coupon.entity;

import com.sh.adm.user.entity.User;
import com.sh.adm.model.enumclass.DiscountRatio;
import com.sh.adm.model.enumclass.IssueDetail;
import lombok.*;
import org.hibernate.annotations.ColumnDefault;
import org.hibernate.annotations.Where;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.YearMonth;

@Getter
@ToString
@EqualsAndHashCode
@NoArgsConstructor
@Where(clause = "blocked = false")
@EntityListeners(AuditingEntityListener.class)
@Entity
public class Coupon {

    @Id
    @Column(name = "coupon_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String couponName;

    private LocalDate startDate;
    private LocalDate endDate;

    @NotNull
    @Enumerated(EnumType.STRING)
    private DiscountRatio discountRatio;

    @Column(nullable = false, precision = 10,scale = 1)
    private BigDecimal abjustPrice;

    private String couponDescription;

    private int numberOfIssues;

    @Enumerated(EnumType.STRING)
    private IssueDetail issueDetail;

    @ColumnDefault("0")
    private boolean blocked;

    @CreatedDate
    private LocalDateTime createdAt;

    @CreatedBy
    private String createdBy;

    @LastModifiedDate
    private LocalDateTime updatedAt;

    @LastModifiedBy
    private String updatedBy;

    @ToString.Exclude
    @ManyToOne(fetch = FetchType.LAZY)
    private User user;

    public void setUser(User user) {
        this.user = user;
    }

    @Builder
    public static Coupon createCoupon(@NotBlank String couponName, @NotNull LocalDate startDate, @NotNull LocalDate endDate, @NotNull DiscountRatio discountRatio, @NotNull BigDecimal abjustPrice, String description, IssueDetail issueDetail) {
        Coupon coupon = new Coupon();
        coupon.couponName = couponName;
        coupon.startDate = startDate;
        coupon.endDate = endDate;
        coupon.discountRatio = discountRatio;
        coupon.abjustPrice = abjustPrice;
        coupon.couponDescription = description;
        coupon.numberOfIssues = 0;
        coupon.issueDetail = issueDetail;
        return coupon;
    }

    public static Coupon birthdayCoupon(@NotBlank LocalDate startDate, int count) {
        Coupon coupon = new Coupon();
        coupon.couponName = startDate.getMonthValue()+"월 생일 쿠폰";
        coupon.startDate = startDate;
        coupon.endDate = YearMonth.from(startDate).atEndOfMonth();
        coupon.discountRatio = DiscountRatio.FORTY;
        coupon.abjustPrice = BigDecimal.ZERO;
        coupon.couponDescription = "월별, 사용자 생일 적용 쿠폰";
        coupon.numberOfIssues += count;
        coupon.issueDetail = IssueDetail.ISSUEBIRTHDY;
        return coupon;
    }

    public void numberOfIssues(int count) {
        this.numberOfIssues += count;
    }
}
