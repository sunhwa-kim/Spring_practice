package com.github.homework.program.repository;


import com.github.homework.program.domain.Program;
import com.github.homework.program.model.ProgramViewDto;
import com.github.homework.theme.domain.Theme;
import com.querydsl.jpa.JPQLQuery;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.support.QuerydslRepositorySupport;
import org.springframework.data.support.PageableExecutionUtils;

import java.util.Comparator;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.github.homework.program.domain.QProgram.program;
import static com.github.homework.theme.domain.QTheme.theme;

public class ProgramCustomRepositoryImpl extends QuerydslRepositorySupport implements ProgramCustomRepository {

    public ProgramCustomRepositoryImpl() {
        super(Program.class);
    }

    @Override
    public Page<ProgramViewDto> findBy(Pageable pageable) {
        JPQLQuery<Program> query = Objects.requireNonNull(getQuerydsl())
                .applyPagination(pageable, from(program)
                        .join(program.themes, theme).fetchJoin()
                        .distinct()
                );

        List<ProgramViewDto> collect = query.fetch().stream()
                .map(program -> new ProgramViewDto(
                                program.getId(),
                                program.getName(),
                                program.getIntroduction(),
                                program.getIntroductionDetail(),
                                program.getRegion(),
                                program.getThemes().stream().sorted(Comparator.comparing(Theme::getName)).map(Theme::getName).collect(Collectors.joining(",")),
                                program.getCount()
                        )
                ).collect(Collectors.toList());
        return PageableExecutionUtils.getPage(collect, pageable, query::fetchCount);
    }
}