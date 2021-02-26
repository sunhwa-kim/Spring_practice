package com.github.homework.program.service;

import static org.assertj.core.api.BDDAssertions.then;
import static org.mockito.BDDMockito.given;

import com.github.homework.program.domain.Program;
import com.github.homework.program.model.ProgramViewDto;
import com.github.homework.program.repository.ProgramRepository;
import com.github.homework.theme.domain.Theme;

import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;

@ExtendWith(MockitoExtension.class)
class ProgramViewServiceImplTest {

    @Mock
    private ProgramRepository programRepository;

    @InjectMocks
    private ProgramViewServiceImpl programViewService;

    @Test
    @DisplayName("프로그램이 한개 일때")
    void getByTest() {
        //given
        Program program = Program.builder()
                .name("name")
                .introduction("introduction")
                .introductionDetail("introductionDetail")
                .region("region")
                .themes(Set.of(new Theme("theme"), new Theme("theme2")))
                .build();

        given(this.programRepository.findById(1L)).willReturn(Optional.of(program));
        //when
        Optional<ProgramViewDto> optionalProgramViewDto = this.programViewService.getBy(1L);
        //then
        then(optionalProgramViewDto).hasValueSatisfying(programViewDto -> {
                    then(programViewDto.getName()).isEqualTo("name");
                    then(programViewDto.getIntroduction()).isEqualTo("introduction");
                    then(programViewDto.getIntroductionDetail()).isEqualTo("introductionDetail");
                    then(programViewDto.getRegion()).isEqualTo("region");
                    then(programViewDto.getThemeName()).isEqualTo("theme2,theme");
                    then(programViewDto.getCount()).isEqualTo(1L);
                }
        );

    }

    @Test
    @DisplayName("프로그램이 이름으로 검색")
    void getByNameTest() {
        //given
        Program program = Program.builder()
                .name("name")
                .introduction("introduction")
                .introductionDetail("introductionDetail")
                .region("region")
                .themes(Set.of(new Theme("theme"), new Theme("theme2")))
                .build();

        given(this.programRepository.findByName("name")).willReturn(Optional.of(program));
        //when
        Optional<ProgramViewDto> optionalProgramViewDto = this.programViewService.getBy("name");
        //then
        then(optionalProgramViewDto).hasValueSatisfying(programViewDto -> {
                    then(programViewDto.getName()).isEqualTo("name");
                    then(programViewDto.getIntroduction()).isEqualTo("introduction");
                    then(programViewDto.getIntroductionDetail()).isEqualTo("introductionDetail");
                    then(programViewDto.getRegion()).isEqualTo("region");
                    then(programViewDto.getThemeName()).isEqualTo("theme2,theme");
                }
        );
    }

    @Test
    @DisplayName("프로그램이 이름으로 검색 결과 없음")
    void getByNameEmptyTest() {
        //given
        //when
        Optional<ProgramViewDto> optionalProgramViewDto = this.programViewService.getBy("name");
        //then
        then(optionalProgramViewDto).isEmpty();
    }

    @Test
    @DisplayName("프로그램이 여러개 일때")
    void pageByTest() {
        //given
        ProgramViewDto programViewDto = new ProgramViewDto(1L, "name", "introduction", "introductionDetail", "region", "themeName",1L);
        given(this.programRepository.findBy(PageRequest.of(0, 100)))
                .willReturn(
                        new PageImpl<>(List.of(programViewDto, programViewDto))
                );

        //when
        Page<ProgramViewDto> programViewDtos = this.programViewService.pageBy(PageRequest.of(0, 100));
        //then
        then(programViewDtos.getContent()).hasSize(2);
        then(programViewDtos.getContent()).allSatisfy(p -> {
                    then(p.getId()).isGreaterThan(0L);
                    then(p.getName()).isEqualTo("name");
                    then(p.getIntroduction()).isEqualTo("introduction");
                    then(p.getIntroductionDetail()).isEqualTo("introductionDetail");
                    then(p.getRegion()).isEqualTo("region");
                    then(p.getThemeName()).isEqualTo("themeName");
                }
        );
    }
    @Test
    @DisplayName("조회수가 상위 10개인 프로그램 ")
    public void topByTest(){
        //given
        Program program = Program.builder()
                .name("name")
                .introduction("introduction")
                .introductionDetail("introductionDetail")
                .region("region")
                .themes(Set.of(new Theme("theme"), new Theme("theme2")))
                .build();
        program.increaseCount();

        given(programRepository.findTop10ByOrderByCountDesc()).willReturn(List.of(program));
        //when
        List<ProgramViewDto> programViewDtos = this.programViewService.topBy();

        //then
        then(programViewDtos).hasSize(1);
        then(programViewDtos).allSatisfy(p -> {
                    then(p.getName()).isEqualTo("name");
                    then(p.getIntroduction()).isEqualTo("introduction");
                    then(p.getIntroductionDetail()).isEqualTo("introductionDetail");
                    then(p.getRegion()).isEqualTo("region");
                    then(p.getThemeName()).isEqualTo("theme2,theme");
                    then(p.getCount()).isEqualTo(1L);
                }
        );
    }
}