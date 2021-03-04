package me.sunhwa.demorestapi.events;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonUnwrapped;
import org.springframework.hateoas.Link;
import org.springframework.hateoas.RepresentationModel;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;

public class EventResource extends RepresentationModel<EventResource> {

    @JsonUnwrapped
    private  Event event;

    @JsonCreator
    public EventResource(@JsonProperty("event") Event event) {
        this.event = event;
//        add(new Link("http//localhost:8080/api/events/"+event.getId()));  // Not type safe
        add(linkTo(EventController.class).slash(event.getId()).withSelfRel());
    }
    public Event getEvent() {
        return event;
    }

}
