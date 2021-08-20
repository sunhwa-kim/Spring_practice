package com.sh.adm.ifs.point;

import com.sh.adm.user.model.entity.User;

import java.math.BigDecimal;
import java.math.RoundingMode;

public class FixPointPolicy implements PointPolicy{

    private final BigDecimal fixedPoint = new BigDecimal("0.01");

    @Override
    public BigDecimal point(User user, BigDecimal price) {
        BigDecimal point = price.multiply(fixedPoint).setScale(0, RoundingMode.DOWN);
        return point;
    }
}
