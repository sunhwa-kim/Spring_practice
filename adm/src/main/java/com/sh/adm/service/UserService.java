package com.sh.adm.service;

import com.sh.adm.exception.UserNotFoundException;
import com.sh.adm.ifs.point.PointPolicy;
import com.sh.adm.model.entity.User;
import com.sh.adm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;

@Transactional
@RequiredArgsConstructor
@Service
public class UserService {

    private final UserRepository userRepository;
    private final PointPolicy rewardPointPolicy;

    public void point(User user, BigDecimal price) {
        User getUser = getUser(user);
        BigDecimal point = rewardPointPolicy.point(getUser, price);
        getUser.rewardPoint(point.longValue());
    }

    private User getUser(User user) {
        return userRepository.findById(user.getId()).orElseThrow(UserNotFoundException::new);
    }
}
