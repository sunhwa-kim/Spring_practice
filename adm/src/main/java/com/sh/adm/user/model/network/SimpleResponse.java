package com.sh.adm.user.model.network;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class SimpleResponse {
    private boolean success;
    private String message;
}
