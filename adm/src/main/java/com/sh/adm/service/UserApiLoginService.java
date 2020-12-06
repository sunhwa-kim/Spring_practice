package com.sh.adm.service;

import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class UserApiLoginService implements CrudInterface<UserApiRequest, UserApiResponse> {
    // req -> data 받아 -> DB save -> 생성 data + Header return
    @Autowired
    private UserRepository userRepository;      //  나중에 추상화로 분리

    @Override
    public Header<UserApiResponse> create(Header<UserApiRequest> request) {

//        request.getData().getAccount();
        UserApiRequest userApiRequest = request.getData();

        User user = User.builder().account(userApiRequest.getAccount())
                .password(userApiRequest.getPassword())
                .status("REGISTERED")     // ENUM
                .email(userApiRequest.getEmail())
                .phoneNumber(userApiRequest.getPhoneNumber())
                .registeredAt(LocalDateTime.now())  // req != res
                .build();
                // createdAt 등은 @EnableJpaAuditing

        User newUser = userRepository.save(user);

        UserApiResponse userApiResponse = UserApiResponse.builder()
                .id(newUser.getId())
                .account(newUser.getAccount())
                .password(newUser.getPassword())
                .status(newUser.getStatus())
                .email(newUser.getEmail())
                .phoneNumber(newUser.getPhoneNumber())
                .registeredAt(newUser.getRegisteredAt())
                .unregisteredAt(newUser.getUnregisteredAt())
                .build();

//        return Header < userApiResponse >;   // error -> 반환값 가지는 메서드 추가
        return Header.OK(userApiResponse);

    }

    @Override
    public Header<UserApiResponse> read(Long id) {
        return null;
    }

    @Override
    public Header<UserApiResponse> update(Header<UserApiRequest> request) {
        return null;
    }

    @Override
    public Header delete(Long id) {
        return null;
    }
}
