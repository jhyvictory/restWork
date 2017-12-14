/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.weijie.restWork.controller;

import com.weijie.restWork.dao.StaffRepository;
import com.weijie.restWork.entity.Staff;
import com.weijie.restWork.service.StaffService;
import com.weijie.restWork.util.JWT;
import com.weijie.restWork.util.ResponseData;
import java.util.Map;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author hyjiang
 */
@RestController
public class StaffAccountController {
    @Autowired
    StaffRepository staffRepository;
    
    @Autowired
    StaffService staffService;
    
    @PostMapping(value = "/login")
    public ResponseData login(@RequestParam( "name") String name,
            @RequestParam("password") String password, HttpServletResponse response) {
        ResponseData responseData = ResponseData.ok();
        Staff staff = staffService.checkLogin(name, password);
        
        if(null != staff) {
            TokenObject tokenObject = new TokenObject(staff.getStaff_id(), staff.getName(), staff.getStaff_type());            
            String token = JWT.sign(tokenObject, 60L* 1000L* 30L);
//            responseData.setValue("loginId", staff.getStaff_id());
//            responseData.setValue("token", token);
            responseData.setValue("staff", staff);
            System.out.println(token);
            response.addHeader("token", token);
        }else{
            responseData =  ResponseData.customerError();
        }   
        return responseData;
    }
    
    @PostMapping("/createUserByMap")
    public void createUserByMap(@RequestBody Map<String,Object> reqMap){
        String tel = reqMap.get("tel").toString();
        String pwd = reqMap.get("pwd").toString();
//        userService.createUser(tel,pwd);
    }
    
//    @PostMapping("/createUser2")
//    public void createUser2(UserInfo userInfo){
//        userService.createUser(userInfo.getTel(),userInfo.getPassWord());
//    }
//        @Max(value = 999999,message = "超过最大数值")
//        @Min(value = 000000,message = "密码设定不正确")
    
//    @PostMapping("/createUser2")
//    public String createUser2(@Valid UserInfo userInfo, BindingResult bindingResult){
//        if (bindingResult.hasErrors()){
//            return bindingResult.getFieldError().getDefaultMessage();
//        }
//        userService.createUser(userInfo.getTel(),userInfo.getPassWord());
//        return "OK";
//    }
    
//    @RequestMapping(path={"/request"})
//    @ResponseBody
//    public String request(Model model, HttpServletRequest request, HttpServletResponse, HttpSession session) {
//        StringBuilder sb = new StringBuilder();
//        sb.append(request.getMethod() + "    ");
//        sb.append(request.getRequestURL() + "    ");
//        sb.append(request.getQueryString() + "    ");  
//        
//        Enumeration<string> headerNames = request.getHeaderNames();
//        while(headerNames.hasMoreElements()) {
//            String name = headerNames.nextElement();
//            sb.append(name + ":" + sb.getHeader(name) + " ");
//        }
//        
//        foreach(Cookie cookie : request.getCookies()) {
//            sb.append("Cookie:" + cookie.getName() + ":" + "Value:" + cookie.getValue());
//        }
//        
//        @CookieValue("JSESSIONID") String sessionId;
//        
//        response.addHeader("nofaker", "Hello");
//        response.addCookie(new Cookie("nofaker", "Cookie"));
//    }
    
    private class TokenObject {
        private String id;
        private String name;
        private String type;

        public TokenObject(String id, String name, String type) {
            this.id = id;
            this.name = name;
            this.type = type;
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }
    }
}
