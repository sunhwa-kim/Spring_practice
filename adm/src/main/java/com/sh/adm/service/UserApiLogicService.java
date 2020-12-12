package com.sh.adm.service;

import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class UserApiLogicService implements CrudInterface<UserApiRequest, UserApiResponse> {
    // req -> data 받아 -> DB save -> 생성 data + Header return
    @Autowired
    private UserRepository userRepository;      //  나중에 추상화로 분리

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

        User newUser = userRepository.save(user);

        return response(newUser);
    }
        // response 중복 -> response()
       /* UserApiResponse userApiResponse = UserApiResponse.builder()
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
        return Header.OK(userApiResponse);*/



    @Override
    public Header<UserApiResponse> read(Long id) {

        return userRepository.findById(id)
//                .map(entity -> response(entity))
                .map(this::response)
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

    private Header<UserApiResponse> response(User user){
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

        return Header.OK(userApiResponse);
    }
}
