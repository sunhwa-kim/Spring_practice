package me.sunhwa.demorestapi.events;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.MethodSource;
import org.junit.jupiter.params.provider.ValueSource;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThat;

class EventTest {

    @Test
    void builder() {
        Event event = Event.builder().build();
        assertThat(event).isNotNull();
    }

    @Test
    void javaBean() {
        Event event = new Event();
        String name = "java bean protocols";
        event.setName(name);
        String description = "study in rest api";
        event.setDescription(description);
        assertThat(event.getName()).isEqualTo(name);
        assertThat(event.getDescription()).isEqualTo(description);
    }

    @DisplayName("무료 확인")
    @ParameterizedTest(name="{index} {displayName} = {2}")
    @MethodSource("paramsProvider")
    void testFree(int basePrice, int maxPrice, boolean isFree) {
        // Given
        Event event = Event.builder()
                .basePrice(basePrice)
                .maxPrice(maxPrice)
                .build();

        // When
        event.update();

        // Then
        assertThat(event.isFree()).isEqualTo(isFree);
    }
    private static Stream<Arguments> paramsProvider() {
        return Stream.of(
                Arguments.arguments(0,0, true),
                Arguments.arguments(100,0,false),
                Arguments.arguments(0,100,false),
                Arguments.arguments(100,200,false)
        );
    }


    @DisplayName("오프라인")
    @ParameterizedTest(name="{index} {displayName} = {1}")
    @CsvSource({
            "서울시, true",
            ", false",
            "'',false"
    })
    void tsetOffLine(String location, boolean isOffline) {
        // Given
        Event event = Event.builder()
                .location(location)
                .build();

        // When
        event.update();

        // Then
        assertThat(event.isOffline()).isEqualTo(isOffline);

    }
}