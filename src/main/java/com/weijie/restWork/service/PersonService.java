/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.weijie.restWork.service;

import com.weijie.restWork.dao.PersonRepository;
import com.weijie.restWork.entity.Person;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author hyjiang
 */
@Service
public class PersonService {
    @Autowired
    private PersonRepository personRepository;
    
    @Transactional
    public void insertTwo() {
        Person personA = new Person();
        personA.setId(3);
        personA.setName("秋雅");
        personA.setAge(19);
        personRepository.save(personA);

//        System.out.print(1/0);

        Person personB = new Person();
        personB.setId(4);
        personB.setName("梦特娇");
        personB.setAge(25);
        personRepository.save(personB);
    }
}
