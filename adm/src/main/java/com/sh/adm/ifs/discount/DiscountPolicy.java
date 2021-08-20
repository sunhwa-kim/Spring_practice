package com.sh.adm.ordergroup.ifs;

import com.sh.adm.user.model.entity.User;

import java.math.BigDecimal;

public interface DiscountPolicy {

    BigDecimal discount(User user, BigDecimal price);

}
