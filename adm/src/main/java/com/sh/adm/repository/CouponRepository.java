package com.sh.adm.repository;

import com.sh.adm.model.entity.coupon.Coupon;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CouponRepository extends JpaRepository<Coupon,Long> {

    List<Coupon> findByCouponName(String name);
}
