package com.adm.shopping.controller;

import com.adm.shopping.model.SearchParam;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("api")
public class PostController {
    // 검색 파라미터가 많은 경우 post 사용
    // HTML <Form>
    // ajax 검색

    // http post body에 data 담아 전송 : @RequestBody로 파라미터 받는다
    // request 형태들 : json, xml, multipart-form / text-plain

    //    @RequestMapping(method= RequestMethod.POST, path="/postMethod")
    //    @PostMapping(value = "/postMethod", produces = {"application-json"}) //  json은 default
    @PostMapping("/postMethod")
    public SearchParam postMethod(@RequestBody SearchParam param){
        return param;
    }
}
