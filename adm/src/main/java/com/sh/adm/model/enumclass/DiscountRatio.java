package com.sh.adm.model.enumclass;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.math.BigDecimal;

@Getter
@AllArgsConstructor
public enum DiscountRatio {
    FORTY(0,40.0f),
    THIRTY(1,30.0f),
    TWENTY(2,20.0f),
    FIFTY(3,15.0f),
    TEN(4,10.0f),
    FIVE(5,5.0f),
    THREE(6,3.0f),
    ONE(7,1.0f),
    HALF(8,0.5F);

    private Integer id;
    private float discount;
}
