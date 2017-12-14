/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.weijie.restWork.dao;

import com.weijie.restWork.entity.Staff;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author hyjiang
 */
public interface StaffRepository extends JpaRepository<Staff,Integer>{

    public Staff findOneByNameAndPassword(String name, String password);
    
}
