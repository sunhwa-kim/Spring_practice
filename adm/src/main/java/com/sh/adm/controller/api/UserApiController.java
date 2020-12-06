package com.sh.adm.controller.api;


import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.model.network.Header;
import com.sh.adm.model.network.request.UserApiRequest;
import com.sh.adm.model.network.response.UserApiResponse;
import com.sh.adm.service.UserApiLoginService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;


@Slf4j
@RestController
@RequestMapping("/api/user")
public class UserApiController implements CrudInterface<UserApiRequest, UserApiResponse> {
    // controller 마다 CRUD 반복 -> Ifs / CrudInterface
    // Header 공통 -> CrudInterface

    // REST 연동 전 규칙 설정 : @PostMapping, @GetMapping, @PutMapping, @DeleteMapping

    @Autowired
    UserApiLoginService userApiLoginService;

    @Override
    @PostMapping("")   // "/api/user"
    public Header<UserApiResponse> create(@RequestBody Header<UserApiRequest> request) {

        //  req -> 받은 데이터? -> DB 저장 by 객체 생성 -> 저장 후 데이터 반환/응답 (저장내용 확인..) : 각각 데이터 별도로
        //   ( Header<UserApiRequest> , User ,  Header<UserApiResponse> )
        //  일단 DB 부분 로직 분리 -> 저장 데이터 여기로 가져와야 : Service
        //  여기는 요청/응답 만

        // service(req) -> CRUD + DB : service 도 CrudInterface 구현...(맘에 안듦)
        // return Header(service(req))
        // return Header + service(req)

        log.info("{}",request);
        return userApiLoginService.create(request);
    }

    @Override
    @GetMapping("{ids}")   //"/api/user/{ids}"
    public Header<UserApiResponse> read(@PathVariable("id") Long id) {
        return null;
    }

    @Override
    @PutMapping("")
    public Header<UserApiResponse> update(Header<UserApiRequest> request) {
        return null;
    }

    @Override
    @DeleteMapping("{id}")
    public Header delete(@PathVariable Long id) {
        return null;
    }

}
