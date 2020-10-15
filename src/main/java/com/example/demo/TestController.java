package com.example.demo;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Optional;

@RestController
@AllArgsConstructor
public class TestController {

    private Environment env;

    @GetMapping("/profile")
    public String getProfile () {
        return Optional.of(env.getActiveProfiles()[0]).orElse("default");
    }

    @GetMapping("/hello")
    public String test() {
        return "Helloooooooooo!!";
    }

}
