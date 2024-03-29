package com.sh.adm.admin.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SearchParameter {
    private String account;
    private String email;
    private int age;
}
