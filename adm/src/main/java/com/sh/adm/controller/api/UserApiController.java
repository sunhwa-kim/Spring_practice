package com.sh.adm.controller.api;


import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.service.UserApiLogicService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Slf4j
@RestController
@RequestMapping("/api/user")
public class UserApiController implements CrudInterface<UserApiRequest, UserApiResponse> {
    // controller 마다 CRUD 반복 -> Ifs / CrudInterface
    // Header 공통 -> CrudInterface
    // REST 연동 전 규칙 설정 : @PostMapping, @GetMapping, @PutMapping, @DeleteMapping
    //  -> 공통, 중복 부분 추상화 리팩토링

    @Autowired
    UserApiLogicService userApiLogicService;

    @GetMapping("")
    public Header<List<UserApiResponse>> getPage(@PageableDefault(sort = "id", size = 15) Pageable pageable) {
        log.info("{}",pageable);
        return userApiLogicService.getPages(pageable);
    }


    @Override
    @PostMapping("")   // "/api/user"
    public Header<UserApiResponse> create(@RequestBody Header<UserApiRequest> request) {

        //  req -> 받은 데이터? -> DB 저장 by 객체 생성 -> 저장 후 데이터 반환/응답 (저장내용 확인..) : 각각 데이터 별도로
        //   ( Header<UserApiRequest> , User ,  Header<UserApiResponse> )
        //  Service
        //  여기는 요청/응답 만

        // service(req) -> CRUD + DB : service 도 CrudInterface 구현...(맘에 안듦)
        // return Header(service(req))
        // return Header + service(req)

        log.info("{}",request);
        return userApiLogicService.create(request);
    }

    @Override
    @GetMapping("{ids}")   //"/api/user/{ids}"
    public Header<UserApiResponse> read(@PathVariable("ids") Long id) {
        return userApiLogicService.read(id);
    }

    @Override
    @PutMapping("")
    public Header<UserApiResponse> update(@RequestBody Header<UserApiRequest> request) {
        // @RequestBody 없으면 null exception
        return userApiLogicService.update(request);
    }

    @Override
    @DeleteMapping("{id}")
    public Header delete(@PathVariable Long id) {
        return userApiLogicService.delete(id);
    }

}
