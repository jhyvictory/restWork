/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.weijie.restWork.entity;

import com.weijie.restWork.util.JpaConverterJson;
import javax.persistence.Column;
import javax.persistence.Convert;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import org.hibernate.annotations.GenericGenerator;

/**
 *
 * @author hyjiang
 */
@Entity
public class Staff {
    @Id
//    @GeneratedValue(generator = "staff-uuid")
//    @GeneratedValue(strategy = GenerationType.AUTO)  
//    @Column(name = "staff_id", nullable = false, length = 32)
    private String staff_id;
    @Column(name = "staff_name", nullable = false)
    private String name;
    private String staff_type;
    private String password;

    private String portrait;
    private String mobile;
    private String email;
    
//    @Convert(converter = JpaConverterJson.class)
//    private Object extra_info;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    private Integer create_time;
    private Integer update_time;

    public Staff() {
    }

    public Staff(String staff_id, String name, String staff_type, String password, String portrait, String mobile, String email, /*Object extra_info,*/ Integer create_time, Integer update_time) {
        this.staff_id = staff_id;
        this.name = name;
        this.staff_type = staff_type;
        this.password = password;
        this.portrait = portrait;
        this.mobile = mobile;
        this.email = email;
//        this.extra_info = extra_info;
        this.create_time = create_time;
        this.update_time = update_time;
    }

//    @GenericGenerator(name = "staff-uuid", strategy = "uuid")
    public String getStaff_id() {
        return staff_id;
    }

    public void setStaff_id(String staff_id) {
        this.staff_id = staff_id;
    }


    public String getStaff_type() {
        return staff_type;
    }

    public void setStaff_type(String staff_type) {
        this.staff_type = staff_type;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPortrait() {
        return portrait;
    }

    public void setPortrait(String portrait) {
        this.portrait = portrait;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

//    public Object getExtra_info() {
//        return extra_info;
//    }
//
//    public void setExtra_info(Object extra_info) {
//        this.extra_info = extra_info;
//    }

    public Integer getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Integer create_time) {
        this.create_time = create_time;
    }

    public Integer getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(Integer update_time) {
        this.update_time = update_time;
    }
    
    

}
