package com.example.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/salutation")
public class GreetingController {

    @GetMapping
    public String salutation() {
        return "Bonjour Master DevOps II";
    }
}

