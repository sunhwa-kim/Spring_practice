package com.sh.adm.component;

import org.springframework.data.domain.AuditorAware;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component   // been
public class LoginUserAuditorAware implements AuditorAware<String> {
    @Override
    public Optional<String> getCurrentAuditor() {
        return Optional.of("AdminUser");
    }
}
    // 감시 대상자 인지하는 interface가 현재 감시대상자 반환  -> @CreatedBy, @UpdatedBy에 입력
