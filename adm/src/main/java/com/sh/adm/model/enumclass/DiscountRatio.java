package com.sh.adm.model.enumclass;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.math.BigDecimal;

@Getter
@AllArgsConstructor
public enum DiscountRatio {
    FORTY(0,BigDecimal.valueOf(40.0)),
    THIRTY(1,BigDecimal.valueOf(30.0)),
    TWENTY(2,BigDecimal.valueOf(20.0)),
    FIFTY(3,BigDecimal.valueOf(15.0)),
    TEN(4,BigDecimal.valueOf(10.0)),
    FIVE(5,BigDecimal.valueOf(5.0)),
    THREE(6,BigDecimal.valueOf(3.0)),
    ONE(7,BigDecimal.valueOf(1.0));

    private Integer id;
    private BigDecimal discount;
}
