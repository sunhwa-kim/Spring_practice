package com.sh.adm.model.enumclass;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;

@Getter
@AllArgsConstructor
public enum IssueDetail {
    ISSUEBIRTHDY(0,"생일 이벤트"),
    ISSUEPARTNER(1,"파트너사 마케팅"),
    ISSUEEVENT(2,"이벤트");

    private Integer id;
    private String description;
}
