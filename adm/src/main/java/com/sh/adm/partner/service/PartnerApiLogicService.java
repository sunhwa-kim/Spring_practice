package com.sh.adm.partner.service;

import com.sh.adm.ifs.CrudInterface;
import com.sh.adm.partner.entity.Partner;
import com.sh.adm.user.model.network.Header;
import com.sh.adm.partner.dto.PartnerApiRequest;
import com.sh.adm.partner.dto.PartnerApiResponse;
import com.sh.adm.category.repository.CategoryRepository;
import com.sh.adm.partner.repository.PartnerRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@RequiredArgsConstructor
@Service
public class PartnerApiLogicService implements CrudInterface<PartnerApiRequest, PartnerApiResponse> {

    private final PartnerRepository partnerRepository;
    private final CategoryRepository categoryRepository;

    @Override
    @Transactional
    public Header<PartnerApiResponse> create(Header<PartnerApiRequest> request) {
        PartnerApiRequest body = request.getData();
        ;
        Partner partner = Partner.builder()
                .name(body.getName())
                .status(body.getStatus())
                .address(body.getAddress())
                .callCenter(body.getCallCenter())
                .partnerNumber(body.getPartnerNumber())
                .businessNumber(body.getBusinessNumber())
                .ceoName(body.getCeoName())
                .category(categoryRepository.getOne(body.getCategoryId()))
                .registeredAt(LocalDateTime.now())  // FE
                .build();

        Partner getPartner = partnerRepository.save(partner);
        return response(getPartner);
    }

    @Override
    @Transactional(readOnly = true)
    public Header<PartnerApiResponse> read(Long id) {
        return partnerRepository.findById(id)
                .map(this::response)
                .orElseGet(() -> Header.error("No data existe"));
    }

    @Override
    public Header<PartnerApiResponse> update(Header<PartnerApiRequest> request) {
        return null;
    }

    @Override
    public Header delete(Long id) {
        return null;
    }

    private Header<PartnerApiResponse> response(Partner partner){

        PartnerApiResponse body = PartnerApiResponse.builder()
                .id(partner.getId())
                .name(partner.getName())
                .status(partner.getStatus())
                .address(partner.getAddress())
                .callCenter(partner.getCallCenter())
                .partnerNumber(partner.getPartnerNumber())
                .businessNumber(partner.getBusinessNumber())
                .ceoName(partner.getCeoName())
                .registeredAt(partner.getRegisteredAt())
                .unregisteredAt(partner.getUnregisteredAt())
                .categoryId(partner.getCategory().getId())
                .build();

        return Header.OK(body);
    }
}
