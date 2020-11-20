package com.sh.adm.controller;

import com.sh.adm.model.SearchParameter;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class PostMethod {
    // 검색 파라미터가 많은 경우 post 사용
    // HTML <Form>
    // ajax 검색

    // http post body에 data 담아 전송 : @RequestBody로 파라미터 받는다
    // request 형태들 : json, xml, multipart-form / text-plain

    // post 요청 테스트는 postman이나 크롬 확장 api로

    //    @RequestMapping(method= RequestMethod.POST, path="/postMethod")
//    @PostMapping(value = "/postMethod", produces = {"application-json"}) // json은 default
    @PostMapping("/PostMethod")  //상단 보다 간단,
    public SearchParameter postMethod(@RequestBody SearchParameter searchParameter){
        return searchParameter;
    }
}
