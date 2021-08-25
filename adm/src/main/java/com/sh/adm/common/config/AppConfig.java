package com.sh.adm.common.config;

import com.sh.adm.common.policy.discount.DiscountPolicy;
import com.sh.adm.common.policy.discount.RatioDiscountPolicy;
import com.sh.adm.common.policy.point.FixPointPolicy;
import com.sh.adm.common.policy.point.PointPolicy;
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
