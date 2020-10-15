package com.example.demo;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@RestController
@AllArgsConstructor
public class TestController {

    private Environment env;

    private Test1 test1;

    private Test2 test2;

    @GetMapping("/profile")
    public String getProfile () {
        return Optional.of(env.getActiveProfiles()[0]).orElse("default");
    }

    @GetMapping("/hello")
    public String test() {
        return "Helloooooooooo!!";
    }


    @GetMapping("/test1")
    public String test1() {
        return test1.getTest1();
    }

    @GetMapping("/test2")
    public String test2() {
        return test2.getTest2();
    }
}
