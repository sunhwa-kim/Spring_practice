package com.sh.adm.common.config;

import com.sh.adm.ifs.discount.DiscountPolicy;
import com.sh.adm.ifs.discount.RatioDiscountPolicy;
import com.sh.adm.ifs.point.FixPointPolicy;
import com.sh.adm.ifs.point.PointPolicy;
import com.sh.adm.ordergroup.ifs.DiscountPolicy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

    @Bean
    public DiscountPolicy discountPolicy() {
        return new RatioDiscountPolicy();
    }

    @Bean
    public PointPolicy pointPolicy() {
        return new FixPointPolicy();
    }
}
