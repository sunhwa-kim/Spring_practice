package com.sh.adm.controller.api;


import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.service.api.UserApiLogicService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/user")
public class UserApiController implements CrudInterface<UserApiRequest, UserApiResponse> {
    // controller 마다 CRUD 반복 -> Ifs / CrudInterface
    // Header 공통 -> CrudInterface
    // REST 연동 전 규칙 설정 : @PostMapping, @GetMapping, @PutMapping, @DeleteMapping
    //  -> 공통, 중복 부분 추상화 리팩토링

    private final UserApiLogicService userApiLogicService;

    @GetMapping("")
    public Header<List<UserApiResponse>> getPage(@PageableDefault(sort = "id", size = 15) Pageable pageable) {
        log.info("{}",pageable);
        return userApiLogicService.getPages(pageable);
    }

    @Override
    @PostMapping("")   // "/api/user"
    @ResponseStatus(HttpStatus.CREATED)  // 201
    public Header<UserApiResponse> create(@RequestBody Header<UserApiRequest> request) {
        log.info("{}",request);
        return userApiLogicService.create(request);
    }

    @Override
    @GetMapping("{id}")   //"/api/user/{ids}"
    public Header<UserApiResponse> read(@PathVariable("id") Long id) {
        return userApiLogicService.read(id);
    }

    @Override
    @PutMapping("")
    public Header<UserApiResponse> update(@RequestBody Header<UserApiRequest> request) {
        return userApiLogicService.update(request);
    }

    @PatchMapping("/change_password/{id}")
    public Header update(@PathVariable Long id, String password) {
        return userApiLogicService.update(id, password);
    }

    @Override
    @DeleteMapping("{id}")
    public Header delete(@PathVariable Long id) {
        return userApiLogicService.delete(id);
    }

    @GetMapping("/deleted_users")
    public Header<List<UserApiResponse>> deletedUsers() {
        return userApiLogicService.getPagesDeletedUser();
    }
}
