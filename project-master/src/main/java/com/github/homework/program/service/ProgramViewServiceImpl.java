package com.github.homework.program.service;

import com.github.homework.program.domain.Program;
import com.github.homework.program.model.ProgramViewDto;
import com.github.homework.program.repository.ProgramRepository;
import com.github.homework.theme.domain.Theme;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ProgramViewServiceImpl implements ProgramViewService {

    private final ProgramRepository programRepository;

    @Override
    @Transactional
    public Optional<ProgramViewDto> getBy(Long id) {
        Optional<Program> byId = programRepository.findById(id);
        byId.ifPresent(Program::increaseCount);
        return byId.map(p ->
                new ProgramViewDto(
                        p.getId(),
                        p.getName(),
                        p.getIntroduction(),
                        p.getIntroductionDetail(),
                        p.getRegion(),
                        p.getThemes().stream().map(Theme::getName).collect(Collectors.joining(",")),
                        p.getCount()
                )
        );
    }

    @Override
    public Optional<ProgramViewDto> getBy(String name) {
        Optional<Program> byId = programRepository.findByName(name);
        return byId.map(p ->
                new ProgramViewDto(
                        p.getId(),
                        p.getName(),
                        p.getIntroduction(),
                        p.getIntroductionDetail(),
                        p.getRegion(),
                        p.getThemes().stream().map(Theme::getName).collect(Collectors.joining(",")),
                        p.getCount()
                )
        );
    }

    @Override
    public Page<ProgramViewDto> pageBy(Pageable pageable) {
        return programRepository.findBy(pageable);
    }

    @Override
    public List<ProgramViewDto> topBy() {
        return programRepository.findTop10ByOrderByCountDesc().stream().map(p -> new ProgramViewDto(
                p.getId(),
                p.getName(),
                p.getIntroduction(),
                p.getIntroductionDetail(),
                p.getRegion(),
                p.getThemes().stream().map(Theme::getName).collect(Collectors.joining(",")),
                p.getCount()
        )).collect(Collectors.toUnmodifiableList());
    }
}
