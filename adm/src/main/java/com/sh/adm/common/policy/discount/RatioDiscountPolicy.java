package com.sh.adm.common.policy.discount;

import com.sh.adm.user.model.entity.User;
import com.sh.adm.ordergroup.model.enumclass.DiscountRatio;
import com.sh.adm.user.enumclass.UserGrade;

import java.math.BigDecimal;

public class RatioDiscountPolicy implements DiscountPolicy{
    @Override
    public BigDecimal discount(User user, BigDecimal price) {
        if(user.getGrade() == UserGrade.GOLD){
            return price.divide(BigDecimal.valueOf(DiscountRatio.TEN.getDiscount()));
        } else if (user.getGrade() == UserGrade.SILVER) {
            return price.divide(BigDecimal.valueOf(DiscountRatio.FIVE.getDiscount()));
        }
        return BigDecimal.ZERO;
    }
}
