/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.weijie.restWork.service;

import com.weijie.restWork.dao.StaffRepository;
import com.weijie.restWork.entity.Staff;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author hyjiang
 */
@Service
public class StaffService {
    @Autowired
    private StaffRepository staffRepository;
    
    public Staff checkLogin(String name, String password){
        System.out.println(name + " " + password);
        Staff staff = staffRepository.findOneByNameAndPassword(name, password);
        return staff;
    }
}
