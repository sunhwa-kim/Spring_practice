package com.sh.adm.item.dto;

import com.sh.adm.item.enumclass.ItemStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ItemApiRequest {
    private Long id;

    private ItemStatus status;  // ItemStatus

    private String name;

    private String title;

    private String content;

    private BigDecimal price;

    private int stockQuantity;

    private String brandName;

    private LocalDateTime registeredAt;

    private LocalDateTime unregisteredAt;

    private Long partnerId;
}
