package com.sh.adm.ifs.point;

import com.sh.adm.user.model.entity.User;

import java.math.BigDecimal;

public interface PointPolicy {
    BigDecimal point(User user, BigDecimal price);
}
