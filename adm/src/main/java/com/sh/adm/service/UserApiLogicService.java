package com.sh.adm.service;

import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.entity.User;
import com.sh.adm.model.enumclass.UserStatus;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
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
@RequiredArgsConstructor
@Service
public class UserApiLogicService implements CrudInterface<UserApiRequest, UserApiResponse> {

    private final UserRepository userRepository;

    // req -> data 받아 -> DB save -> 생성 data + Header return
    
    /*
    service 내 UserApiRequest -> User 변환 로직
    Controller 내 request data null값 반환 -> User 내에서 자체 변환, User 생성
     */
    @Transactional(readOnly = true)
    public Header<List<UserApiResponse>> getPages(Pageable pageable) {
        Page<User> users = userRepository.findAll(pageable);

        List<UserApiResponse> res = users.stream()
                .map(user -> response(user))
                .collect(Collectors.toList());
        return Header.OK(res);
    }

    @Override
    @Transactional
    public Header<UserApiResponse> create(Header<UserApiRequest> request) {
        UserApiRequest userApiRequest = request.getData();
        vaildateDupplicatedAccount(userApiRequest.getAccount());
        User user = User.of(userApiRequest.getAccount(), userApiRequest.getPassword(), userApiRequest.getStatus(), userApiRequest.getEmail(), userApiRequest.getPhoneNumber(),userApiRequest.getBirthday(),LocalDateTime.now());
        User newUser = userRepository.save(user);  // createdAt 등은 @EnableJpaAuditing
        return Header.OK(response(user));
    }

    @Override
    @Transactional(readOnly = true)
    public Header<UserApiResponse> read(Long id) {
        return userRepository.findById(id)
                .map(this::response)
                .map(Header::OK)
                .orElseGet(() -> error("The id dose not existed"));
    }

    @Override
    @Transactional
    public Header<UserApiResponse> update(Header<UserApiRequest> request) {
        // id -> data -> change data(req) -> update
        UserApiRequest userApiRequest = request.getData();
        validateEqualsAccount(userApiRequest.getId(), userApiRequest.getAccount());
        return userRepository.findById(userApiRequest.getId())
                .map(entity -> {
                    entity.userUpdate(userApiRequest);
                    return entity;
                })
                .map(this::response)
                .map(Header::OK)
                .orElseGet(() -> error("The Account dose not existed"));
    }

    @Transactional
    public Header<UserApiResponse> update(Long id, String password) {
        return userRepository.findById(id)
                .map(user -> {
                    if(user.getPassword().equals(password)) throw new RuntimeException("Enter a different number");
                    user.setPassword(password);
                    return user;
                })
                .map(this::response)
                .map(Header::OK)
                .orElseGet(() -> error("No data existed"));
    }

    @Override
    @Transactional
    public Header delete(Long id) {
        return userRepository.findById(id)
                .map(entity -> {
                    entity.deledtedAccount(LocalDateTime.now(), UserStatus.UNREGISTERED, true);
//                    userRepository.save(entity);
                    return Header.OK();
                }).orElseGet(() -> error("No data exited"));
    }

    @Transactional(readOnly = true)
    public Header<List<UserApiResponse>> getPagesDeletedUser() {
        List<UserApiResponse> res = new ArrayList<>();
        List<User> userDeleted = userRepository.findUserDeleted();
        if (userDeleted.size() > 0) {
            List<UserApiResponse> collect = userDeleted.stream()
                    .map(user -> response(user)).collect(Collectors.toUnmodifiableList());
            return Header.OK(collect);
        }
        return error("No data existed");
    }

    // response 중복 -> response()
    private void vaildateDupplicatedAccount(String account) {
        int getCount = userRepository.findByAccount(account).size();
        if (getCount > 0) {
            throw new IllegalStateException("The account already exists");
        }
    }

    private void validateEqualsAccount(Long id, String account) {
        User getUser = userRepository.findById(1L).orElseThrow(() -> new RuntimeException("No data exist"));
        if(!getUser.getAccount().equals(account)) throw new RuntimeException("You can't change your Account");
    }
//                .orElseThrow(() -> new RuntimeException("The account is not available."));  // 가능할까...?

    private UserApiResponse response(User user) {
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
