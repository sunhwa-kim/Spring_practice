package com.sh.adm.model.entity.coupon;

import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.DiscountRatio;
import com.sh.adm.model.enumclass.IssueDetail;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
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

@ToString
@Getter
@NoArgsConstructor
@EntityListeners(AuditingEntityListener.class)
@Where(clause = "blocked = false")
@Entity
public class Coupon {

    @Id
    @Column(name = "coupon_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank
    private String couponName;

    private LocalDate startDate;
    private LocalDate endDate;

    @NotNull
    @Enumerated(EnumType.STRING)
    private DiscountRatio discountRatio;

    @NotNull
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

    @ManyToOne(fetch = FetchType.LAZY)
    private User users;

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

    public static Coupon birthdayCoupon(@NotBlank String couponName, @NotBlank LocalDate startDate, int count) {
        Coupon coupon = new Coupon();
        coupon.couponName = couponName;
        coupon.startDate = startDate;
        coupon.endDate = YearMonth.from(startDate).atEndOfMonth();
        coupon.discountRatio = DiscountRatio.FORTY;
        coupon.abjustPrice = BigDecimal.ZERO;
        coupon.couponDescription = "월별 생일자 적용";
        coupon.numberOfIssues += count;
        coupon.issueDetail = IssueDetail.ISSUEBIRTHDY;
        return coupon;
    }

    public void numberOfIssues(int count) {
        this.numberOfIssues += count;
    }
}