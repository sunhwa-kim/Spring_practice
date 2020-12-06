package com.sh.adm.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@Configuration    //  xml에 설정 file 추가
@EnableJpaAuditing    //  JPA 활성
public class JpaConfig {
}
