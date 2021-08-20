package com.sh.adm.repository;

import com.sh.adm.coupon.model.entity.Coupon;
import com.sh.adm.coupon.repository.CouponRepository;
import com.sh.adm.ordergroup.model.enumclass.DiscountRatio;
import com.sh.adm.coupon.model.IssueDetail;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.transaction.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;

import static org.assertj.core.api.BDDAssertions.then;
import static org.junit.jupiter.api.Assertions.*;

@Transactional
@SpringBootTest
class CouponRepositoryTest {

    @Autowired
    CouponRepository couponRepository;

    @Test
    void post() {
        Coupon coupon = Coupon.createCoupon("가입 쿠폰", LocalDate.now(), LocalDate.now().plusDays(14), DiscountRatio.FIVE, BigDecimal.valueOf(10000), "회원 가입 기본 지급 쿠폰", IssueDetail.ISSUEEVENT);
        couponRepository.save(coupon);
        List<Coupon> registerCoupon = couponRepository.findByCouponName("가입 쿠폰");
//        log.info("register coupon >> {}",registerCoupon);
        assertAll(
                () -> then(registerCoupon.get(0).getCouponName()).isEqualTo("가입 쿠폰"),
                () -> then(registerCoupon.get(0).getStartDate()).isEqualTo(LocalDate.now()),
                () -> then(registerCoupon.get(0).getEndDate()).isEqualTo(LocalDate.now().plusDays(14)),
                () -> then(registerCoupon.get(0).getDiscountRatio()).isEqualTo(DiscountRatio.FIVE),
                () -> then(registerCoupon.get(0).getAbjustPrice()).isEqualTo(BigDecimal.valueOf(10000)),
                () -> then(registerCoupon.get(0).getCouponDescription()).isEqualTo("회원 가입 기본 지급 쿠폰"),
                () -> then(registerCoupon.get(0).getIssueDetail()).isEqualTo(IssueDetail.ISSUEEVENT)
        );
    }

    @Test
    void postOfBirthday() {
        LocalDate start = LocalDate.of(2021, 2, 1);
        Coupon coupon = Coupon.birthdayCoupon(start, 100);
//        log.info(" birthday >> {}",coupon);
        Coupon savedCoupon = couponRepository.save(coupon);
        assertAll(
                () -> then(savedCoupon.getCouponName()).isEqualTo("2월 생일 쿠폰"),
                () -> then(savedCoupon.getStartDate()).isEqualTo(start),
                () -> then(savedCoupon.getEndDate()).isEqualTo(YearMonth.from(start).atEndOfMonth()),
                () -> then(savedCoupon.getDiscountRatio()).isEqualTo(DiscountRatio.FORTY),
                () -> then(savedCoupon.getAbjustPrice()).isEqualTo(BigDecimal.ZERO),
                () -> then(savedCoupon.getCouponDescription()).isEqualTo("월별, 사용자 생일 적용 쿠폰"),
                () -> then(savedCoupon.getNumberOfIssues()>=100).isTrue(),
                () -> then(savedCoupon.getIssueDetail()).isEqualTo(IssueDetail.ISSUEBIRTHDY)
        );
    }
}