package com.sh.adm.ifs;

import com.sh.adm.model.network.Header;

public interface CrudInterface<Request, Response> {
    // controller 마다 CRUD 반복 -> Ifs / CrudInterface
    // Header 공통 -> CrudInterface
    // Header 언제 이용? -> request, response  in Controller
    
    // Controller 마다 다른 데이터
    //  요청 데이터가 Header를 통해서 -> create, update : <T> data ( instance )
    //  -> /network/request, /network/response (각각 데이타 다르니까)

    Header<Response> create(Header<Request> request);  // todo request object 추가

    Header<Response> read(Long id);

    Header<Response> update(Header<Request> request);

    Header delete(Long id);
}
