package com.sh.adm.orderdetail.dto;

import com.sh.adm.user.model.network.request.OrderItem;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class OrderDetailListApiRequest {

    private List<OrderItem> itemList = new ArrayList<>();

    private Set<OrderItem> items = new HashSet<>();

    private Long order_group_id;
}

