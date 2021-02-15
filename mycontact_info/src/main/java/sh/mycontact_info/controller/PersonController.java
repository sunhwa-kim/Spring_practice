package sh.mycontact_info.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import sh.mycontact_info.controller.dto.PersonDto;
import sh.mycontact_info.domain.entity.Person;
import sh.mycontact_info.service.PersonService;

@RequestMapping("/api/person")
@Controller
@RequiredArgsConstructor
public class PersonController {

    private final PersonService personService;

    @GetMapping("/{id}")   // url의 특정 위치값 variable로 받겠다
    public Person getPerson(@PathVariable Long id) {
        return personService.getPerson(id);
    }

    @PostMapping
    @ResponseStatus(HttpStatus.CREATED)  // 201
    public void postPerson(@RequestBody PersonDto personDto) {
        personService.put(personDto);
//        log.info("person -> {} ", personRepository.findAll());
    }

    @PutMapping("{id}")
    public void modifyPerson(@PathVariable Long id, @RequestBody PersonDto person) {
        personService.modify(id, person);
    }

    @PatchMapping("/{id}")  // 일부 리소스만 update 의미
    public void modifyPerson(@PathVariable Long id, String phoneNumber) {   // 메서드명이 Put하고 같아야 하나?
        personService.modify(id, phoneNumber);
    }

    @DeleteMapping("{id}")
    public void deletePerson(@PathVariable Long id) {
        personService.delete(id);
    }
}
