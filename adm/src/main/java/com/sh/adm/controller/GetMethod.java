package com.sh.adm.controller;

import com.sh.adm.model.SearchParameter;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api")
public class GetMethod {

    @RequestMapping(method= RequestMethod.GET, path="/getMethod")
    public String getRequest() {
        return "get getMethod!";
    }

    @GetMapping("/getMethod")
    public String getMethod(@RequestParam String date, @RequestParam(name = "password") String pwd){
        String password = "test-pwd";
        return date+pwd;
    }

    // localhost:8080/api/getMultiParam?account=1234&email=test@gmail.com&age=33
    @GetMapping("/getMultiParam")
    public SearchParameter getMultiParam(SearchParameter param){
        System.out.println(param.getAccount());
        System.out.println(param.getEmail());
        System.out.println(param.getAge());
        return param;  // JSON 방식
    }

}
