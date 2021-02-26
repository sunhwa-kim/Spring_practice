package com.github.homework.program.domain;


import com.github.homework.theme.domain.Theme;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.*;

import lombok.AccessLevel;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@SequenceGenerator(
        name = "program_seq_generator",
        sequenceName = "program_seq", allocationSize = 10)
@EqualsAndHashCode(of = "id")
@ToString
public class Program {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE,
            generator = "program_seq_generator")
    private Long id;
    private String name;
    private String introduction;
    private String region;
    private String introductionDetail;
    private Long count = 0L;

    @OneToMany(mappedBy = "program", cascade = CascadeType.ALL)
    private Set<Theme> themes = new HashSet<>();

    @Builder
    public Program(String name, String introduction, String introductionDetail, String region, Set<Theme> themes) {
        this.name = name;
        this.introduction = introduction;
        this.introductionDetail = introductionDetail;
        this.region = region;
        this.themes.addAll(themes);
        themes.forEach(theme -> theme.setProgram(this));
    }

    public void updateProgram(String name, String introduction, String introductionDetail, String region,
                              Set<Theme> themes) {
        this.name = name;
        this.introduction = introduction;
        this.introductionDetail = introductionDetail;
        this.region = region;
        this.themes.retainAll(themes);
        themes.forEach(theme -> theme.setProgram(this));
    }

    public void increaseCount(){
        this.count++;
    }
}
