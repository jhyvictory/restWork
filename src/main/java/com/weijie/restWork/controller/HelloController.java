/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.weijie.restWork.controller;

import com.weijie.restWork.PersonProperties;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author hyjiang
 */
@RestController
public class HelloController {
//    @Value("${name}")
//    private String name;
    
    @Autowired
    private PersonProperties personProperties;
    
    @RequestMapping(value = "/hello", method = RequestMethod.GET)
    public String index(){
//        return name + "hello world";
        return personProperties.getName()+personProperties.getAge();
    }
}
