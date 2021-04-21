package com.sh.adm.config;

import com.sh.adm.ifs.discount.DiscountPolicy;
import com.sh.adm.ifs.discount.RatioDiscountPolicy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

    @Bean
    public DiscountPolicy discountPolicy() {
        return new RatioDiscountPolicy();
    }
}
