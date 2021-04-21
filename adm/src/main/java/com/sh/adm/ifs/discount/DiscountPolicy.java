package com.sh.adm.ifs.discount;

import com.sh.adm.model.entity.User;

import java.math.BigDecimal;

public interface DiscountPolicy {

    BigDecimal discount(User user, BigDecimal price);

}
