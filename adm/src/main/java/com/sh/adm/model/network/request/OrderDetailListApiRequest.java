package com.sh.adm.model.network.request;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailListApiRequest {

    private List<OrderItem> items = new ArrayList<>();

    private Long order_group_id;
}

