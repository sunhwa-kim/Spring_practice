package com.adm.shopping.controller;

import com.adm.shopping.model.SearchParam;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class GetController {

    @GetMapping("/getMethod")
    public String getMethod(){

        return "get OK!";
    }

    @GetMapping("/getParameter")
    public String getParameter(@RequestParam String email, @RequestParam String pwd){

        return email+pwd;
    }


    //http://localhost:8080/api/getMultiParam?account=user&email=goldiy@naver.com&page=12
    @GetMapping("/getMultiParam")
    public SearchParam getMultiParam(SearchParam param){

        return param;
    }

}
