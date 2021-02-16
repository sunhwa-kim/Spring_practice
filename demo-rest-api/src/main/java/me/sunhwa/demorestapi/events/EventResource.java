package me.sunhwa.demorestapi.events;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonUnwrapped;
import org.springframework.hateoas.RepresentationModel;

public class EventResource extends RepresentationModel<EventResource> {

    @JsonUnwrapped
    private  Event event;

    @JsonCreator
    public EventResource(@JsonProperty("event") Event event) {
        this.event = event;
    }

    public Event getEvent() {
        return event;
    }
}
