package me.sunhwa.demorestapi.events;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.net.URI;

import static org.springframework.hateoas.server.mvc.WebMvcLinkBuilder.linkTo;

@Controller
@RequestMapping(value = "/api/events")
public class EventController {

    @PostMapping
    public ResponseEntity createEvent(@RequestBody Event event) {
        //HATEOS
//        URI createUri = linkTo(methodOn(EventController.class)).slash("{id}").toUri();  // jUnit4
        URI createUri = linkTo(EventController.class).slash("{id}").toUri();
        event.setId(10);
        return ResponseEntity.created(createUri).body(event);
    }
}
