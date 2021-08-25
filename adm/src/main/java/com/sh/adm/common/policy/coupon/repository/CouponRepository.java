package com.sh.adm.common.policy.coupon.repository;

import com.sh.adm.common.policy.coupon.model.Coupon;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CouponRepository extends JpaRepository<Coupon,Long> {
    List<Coupon> findByCouponName(String name);
}
