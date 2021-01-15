package com.sh.adm.service;

import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserApiLogicService implements CrudInterface<UserApiRequest, UserApiResponse> {
    // req -> data 받아 -> DB save -> 생성 data + Header return
    @Autowired
    private UserRepository userRepository;      //  나중에 추상화로 분리

    public Header<List<UserApiResponse>> getPages(Pageable pageable) {
        Page<User> users = userRepository.findAll(pageable);

        List<UserApiResponse> res = users.stream()
                .map(user -> response(user))
                .collect(Collectors.toList());

        return Header.OK(res);
    }

    @Override
    public Header<UserApiResponse> create(Header<UserApiRequest> request) {

//        request.getData().getAccount();
        UserApiRequest userApiRequest = request.getData();

        User user = User.builder()
                .account(userApiRequest.getAccount())
                .password(userApiRequest.getPassword())
//                .status("REGISTERED")     // -> ENUM
                .status(userApiRequest.getStatus())     // ENUM
                .email(userApiRequest.getEmail())
                .phoneNumber(userApiRequest.getPhoneNumber())
                .registeredAt(LocalDateTime.now())  // req != res
                .build();
                // createdAt 등은 @EnableJpaAuditing
        vaildateDupplicatedAccount(user);
        User newUser = userRepository.save(user);

        return Header.OK(response(newUser));
    }

    // response 중복 -> response()
    private void vaildateDupplicatedAccount(User user) {
        long userCount = userRepository.findByAccount(user.getAccount()).size();
        if (userCount > 0) {
            throw new IllegalStateException("이미 존재하는 계정입니다.");
        }
    }

    @Override
    public Header<UserApiResponse> read(Long id) {

        return userRepository.findById(id)
//                .map(entity -> response(entity))
                .map(this::response)
                .map(Header::OK)
                .orElseGet(() -> Header.error("No data existed"));
    }

    @Override
    public Header<UserApiResponse> update(Header<UserApiRequest> request) {
        // id -> data -> change data(req) -> update
        UserApiRequest userReq = request.getData();
        return userRepository.findById(userReq.getId())
//                .map(entity -> UserChain(entity,userReq) )
                .map(entity -> {
                    entity
                            .setAccount(userReq.getAccount())
                            .setPassword(userReq.getPassword())
                            .setStatus(userReq.getStatus())
                            .setEmail(userReq.getEmail())
                            .setPhoneNumber(userReq.getPhoneNumber())
                            .setRegisteredAt(userReq.getRegisteredAt())
                            .setUnregisteredAt(userReq.getUnregisteredAt());
                    return entity;
                } )
                .map(this::response)
                .map(Header::OK)
                .orElseGet(() -> Header.error("No data existed"));
    }

    @Override
    public Header delete(Long id) {
        return userRepository.findById(id)
                .map(entity -> {
                    userRepository.delete(entity);
                    return Header.OK();
                }).orElseGet(() -> Header.error("No data exited"));
    }

    //  not good...
   private User UserChain(User entity, UserApiRequest req) {
          entity
                .setAccount(req.getAccount())
                .setPassword(req.getPassword())
                .setStatus(req.getStatus())
                .setEmail(req.getEmail())
                .setPhoneNumber(req.getPhoneNumber())
                .setRegisteredAt(req.getRegisteredAt())
                .setUnregisteredAt(req.getUnregisteredAt());
        return entity;
    }

    private UserApiResponse response(User user){
        // save ine response's date and send response data
        String getStatus = user.getStatus().getTitle();
        UserApiResponse userApiResponse = UserApiResponse.builder()
                .id(user.getId())
                .account(user.getAccount())
                .password(user.getPassword())
                .status(getStatus)
                .email(user.getEmail())
                .phoneNumber(user.getPhoneNumber())
                .registeredAt(user.getRegisteredAt())
                .unregisteredAt(user.getUnregisteredAt())
                .build();

        return userApiResponse;
//        return Header.OK(userApiResponse);
    }
}
