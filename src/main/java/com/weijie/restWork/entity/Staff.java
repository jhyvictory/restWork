/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.weijie.restWork.entity;

import javax.persistence.Convert;
import javax.persistence.Entity;
import javax.persistence.Id;

/**
 *
 * @author hyjiang
 */
@Entity
public class Staff {
    @Id
    private String staff_id;    
    private String staff_name;
    private String staff_type;
    private String password;

    private String portrait;
    private String mobile;
    private String email;
    
    @Convert(converter = JpaConverterJson.class)
    private Object extra_info;

   
}
