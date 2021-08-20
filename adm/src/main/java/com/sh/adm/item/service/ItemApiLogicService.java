package com.sh.adm.item.service;

import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.item.entity.Item;
import com.sh.adm.user.model.network.Header;
import com.sh.adm.item.dto.ItemApiRequest;
import com.sh.adm.item.dto.ItemApiResponse;
import com.sh.adm.item.repository.ItemRepository;
import com.sh.adm.partner.repository.PartnerRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@RequiredArgsConstructor
@Service
public class ItemApiLogicService implements CrudInterface<ItemApiRequest, ItemApiResponse> {

    private final ItemRepository itemRepository;
    private final PartnerRepository partnerRepository;

    @Override
    @Transactional
    public Header<ItemApiResponse> create(Header<ItemApiRequest> request) {

        ItemApiRequest body = request.getData();

        Item item = Item.builder()
                .status(body.getStatus())
                .name(body.getName())
                .title(body.getTitle())
                .content(body.getContent())
                .price(body.getPrice())
                .stockQuantity(body.getStockQuantity())
                .brandName(body.getBrandName())
                .registeredAt(LocalDateTime.now())
                .partner(partnerRepository.getOne(body.getPartnerId()))
                .build();

        Item getItem = itemRepository.save(item);
        return response(getItem);
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
        return null;
    }

    public Header<ItemApiResponse> response(Item item){

        ItemApiResponse body = ItemApiResponse.builder()
                .id(item.getId())
                .status(item.getStatus())
                .name(item.getName())
                .title(item.getTitle())
                .content(item.getContent())
                .price(item.getPrice())
                .brandName(item.getBrandName())
                .registeredAt(item.getRegisteredAt())
                .unregisteredAt(item.getUnregisteredAt())
                .partnerId(item.getPartner().getId())
                .build();

        return Header.OK(body);
    }
}
