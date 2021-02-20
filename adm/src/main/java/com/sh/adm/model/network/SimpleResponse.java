package com.sh.adm.model.network;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@AllArgsConstructor
public class SimpleResponse {
    private boolean success;
    private String message;
}
