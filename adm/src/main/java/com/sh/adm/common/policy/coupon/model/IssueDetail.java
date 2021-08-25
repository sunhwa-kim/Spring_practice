package com.sh.adm.common.policy.coupon.model;


import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum IssueDetail {
    ISSUEBIRTHDY(0,"생일 이벤트"),
    ISSUEPARTNER(1,"파트너사 마케팅"),
    ISSUEEVENT(2,"이벤트");

    private Integer id;
    private String description;
}
