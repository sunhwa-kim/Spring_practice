package com.github.homework.program.model;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@ToString
public class ProgramViewDto {

    private Long id;
    private String name;
    private String introduction;
    private String introductionDetail;
    private String region;
    private String themeName;
    private Long count;

    public ProgramViewDto(Long id, String name, String introduction, String introductionDetail, String region, String themeName, Long count) {
        this.id = id;
        this.name = name;
        this.introduction = introduction;
        this.introductionDetail = introductionDetail;
        this.region = region;
        this.themeName = themeName;
        this.count = count;
    }
}
