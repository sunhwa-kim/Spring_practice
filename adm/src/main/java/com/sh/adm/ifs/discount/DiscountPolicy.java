package com.sh.adm.ifs.discount;

import com.sh.adm.user.entity.User;

import java.math.BigDecimal;

public interface DiscountPolicy {

    BigDecimal discount(User user, BigDecimal price);

}
