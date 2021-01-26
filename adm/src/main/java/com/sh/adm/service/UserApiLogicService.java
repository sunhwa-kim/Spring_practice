package com.sh.adm.service;

import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserAccount;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.sh.adm.model.network.Header.error;

@Slf4j
@Transactional
@Service
public class UserApiLogicService implements CrudInterface<UserApiRequest, UserApiResponse> {
    // req -> data 받아 -> DB save -> 생성 data + Header return
    @Autowired
    private UserRepository userRepository;

    @Transactional(readOnly = true)
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
        int getCount = userRepository.findByAccount(user.getAccount()).size();
        if (getCount > 0) {
            throw new IllegalStateException("이미 존재하는 계정입니다.");
        }
    }
    @Transactional(readOnly = true)
    @Override
    public Header<UserApiResponse> read(Long id) {
        return userRepository.findById(id)
                .map(this::response)
                .map(Header::OK)
                .orElseGet(() -> error("No data existed"));
    }

    @Override
    public Header<UserApiResponse> update(Header<UserApiRequest> request) {
        // id -> data -> change data(req) -> update
        UserApiRequest userReq = request.getData();
        checkUnChangedAccount(userReq.getId(), userReq.getAccount());

        return userRepository.findById(userReq.getId())
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
                .orElseGet(() -> error("No data existed"));
    }

    private void checkUnChangedAccount(Long id, String userName) {
        User user = userRepository.findById(id).get();
        if(!user.getAccount().equals(userName)) throw new RuntimeException("ID를 변경 하실 수 없습니다.");
    }

    public Header<UserApiResponse> update(Long id, String password) {
        return userRepository.findById(id)
                .map(user -> user.setPassword(password))
                .map(this::response)
                .map(Header::OK)
                .orElseGet(() -> error("No data existed"));
    }

    @Override
    public Header delete(Long id) {
        return userRepository.findById(id)
                .map(entity -> {
//                    log.info("user -> {}",userRepository.findAll());
                    entity.setDeleted(true);
//                    userRepository.save(entity);   // jpa !
                    return Header.OK();
                }).orElseGet(() -> error("No data exited"));
    }

    @Transactional(readOnly = true)
    public Header<List<UserApiResponse>> getPagesDeletedUser() {
        List<UserApiResponse> res =new ArrayList<>();
        List<User> userDeleted = userRepository.findUserDeleted();
        if (userDeleted.size() > 0) {
            List<UserApiResponse> collect = userDeleted.stream()
                    .map(user -> response(user)).collect(Collectors.toUnmodifiableList());
            return Header.OK(collect);
        }
            return error("No data existed");

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
