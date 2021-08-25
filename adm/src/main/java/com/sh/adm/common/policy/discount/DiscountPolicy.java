package com.sh.adm.common.policy.discount;

import com.sh.adm.user.model.entity.User;

import java.math.BigDecimal;

public interface DiscountPolicy {

    BigDecimal discount(User user, BigDecimal price);

}
