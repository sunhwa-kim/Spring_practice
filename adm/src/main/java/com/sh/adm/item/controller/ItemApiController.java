package com.sh.adm.item.controller;

import com.sh.adm.common.ifs.CrudInterface;
import com.sh.adm.common.model.packet.Header;
import com.sh.adm.item.dto.ItemApiRequest;
import com.sh.adm.item.dto.ItemApiResponse;
import com.sh.adm.item.service.ItemApiLogicService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/item")
@RequiredArgsConstructor
public class ItemApiController implements CrudInterface<ItemApiRequest, ItemApiResponse> {

    private final ItemApiLogicService itemApiLogicService;

    @Override
    @PostMapping("")
    @ResponseStatus(HttpStatus.CREATED)
    public Header<ItemApiResponse> create(@RequestBody Header<ItemApiRequest> request) {
        return itemApiLogicService.create(request);
    }

    @Override
    public Header<ItemApiResponse> read(Long id) {
        return null;
    }

    @Override
    public Header<ItemApiResponse> update(Header<ItemApiRequest> request) {
        return null;
    }

    @Override
    public Header delete(Long id) {
        return Header.OK();
    }
}
