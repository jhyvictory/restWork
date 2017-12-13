/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.weijie.restWork.dao;

import com.weijie.restWork.entity.Person;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author hyjiang
 */
public interface PersonRepository extends JpaRepository<Person,Integer> {
    /**
     * 通过年龄来查询
     * 方法名固定findByAge
     * @param age
     * @return
     */ 
    
    public List<Person> findByAge(Integer age);
}
