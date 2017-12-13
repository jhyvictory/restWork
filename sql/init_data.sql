/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  hyjiang
 * Created: 2017-12-13
 */

USE `testdb` ;

DELETE FROM `testdb`.`person`;
INSERT INTO `testdb`.`person`(id, age, name) VALUES(1, 23, '夏洛');
INSERT INTO `testdb`.`person`(id, age, name) VALUES(2, 21, '马冬梅');

DELETE FROM `testdb`.`staff`;
INSERT INTO `testdb`.`staff`(staff_id, staff_name, staff_type, password, portrait, mobile, email) 
 VALUES("53102b43bf1044ed8b0ba35c", "admin", "admin", MD5(MD5("admin123456")), "", "18805697820", "jhyvictory@foxmail.com");