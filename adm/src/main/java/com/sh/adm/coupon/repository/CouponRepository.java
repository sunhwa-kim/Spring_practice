package com.sh.adm.coupon.repository;

import com.sh.adm.coupon.model.entity.Coupon;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CouponRepository extends JpaRepository<Coupon,Long> {

    List<Coupon> findByCouponName(String name);
}
