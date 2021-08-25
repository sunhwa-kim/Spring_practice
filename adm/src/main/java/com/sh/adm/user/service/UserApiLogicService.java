package com.sh.adm.user.service;

import com.sh.adm.common.model.packet.Header;
import com.sh.adm.user.model.entity.User;
import com.sh.adm.user.model.dto.UserApiRequest;
import com.sh.adm.user.model.dto.UserApiResponse;
import com.sh.adm.user.repository.UserRepository;
import com.sh.adm.utils.date.DatePattern;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.sh.adm.common.model.packet.Header.error;

@Slf4j
@RequiredArgsConstructor
@Service
public class UserApiLogicService{

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

    @Transactional
    public Header<UserApiResponse> create(UserApiRequest userApiRequest) {
        vaildateDupplicatedAccount(userApiRequest.getAccount());
        User user = User.of(userApiRequest.getAccount(), userApiRequest.getPassword(), userApiRequest.getStatus(), userApiRequest.getEmail(), userApiRequest.getPhoneNumber(),userApiRequest.getBirthday());
        User newUser = userRepository.save(user);  // createdAt 등은 @EnableJpaAuditing
        return Header.OK(response(newUser));
    }

    @Transactional(readOnly = true)
    public Header<UserApiResponse> read(Long id) {
        return userRepository.findById(id)
                .map(this::response)
                .map(Header::OK)
                .orElseGet(() -> error("The id dose not existed"));
    }

    @Transactional
    public Header<UserApiResponse> update(UserApiRequest userApiRequest) {
        // id -> data -> change data(req) -> update
        validateEqualsAccount(userApiRequest.getId(), userApiRequest.getAccount());
        return userRepository.findById(userApiRequest.getId())
                .map(user -> {
                    user.personalInfoUpdate(userApiRequest);
                    return user;
                })
                .map(this::response)
                .map(Header::OK)
                .orElseGet(() -> error("The Account dose not existed"));
    }

    @Transactional
    public Header<UserApiResponse> update(Long id, String password) {
        return userRepository.findById(id)
                .map(user -> {
                    user.updatePassword(password);
                    return user;
                })
                .map(this::response)
                .map(Header::OK)
                .orElseGet(() -> error("No data existed"));
    }

    @Transactional
    public Header delete(Long id) {
        return userRepository.findById(id)
                .map(entity -> {
                    entity.deledtedAccount();
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
        if (userRepository.existsByAccount(account)) {
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
        System.out.println(user.toString());
        String birthday = new DatePattern(user.getBirthday().getLocalDate()).yearMonthDay();
        UserApiResponse userApiResponse = UserApiResponse.builder()
                .id(user.getId())
                .account(user.getAccount())
                .status(getStatus)
                .email(user.getEmail())
                .phoneNumber(user.getPhoneNumber())
                .birthday(birthday)
                .registeredAt(user.getRegisteredAt())
                .unregisteredAt(user.getUnregisteredAt())
                .build();
        return userApiResponse;
//        return Header.OK(userApiResponse);
    }


}
