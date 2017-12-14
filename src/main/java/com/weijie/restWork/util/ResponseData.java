/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.weijie.restWork.util;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author hyjiang
 */
public class ResponseData {
    private final String errmsg;
    private final int errno;

    public String getErrmsg() {
        return errmsg;
    }

    public int getErrno() {
        return errno;
    }
    private final Map<String, Object> data = new HashMap<String, Object>();

    public Map<String, Object> getData() {
        return data;
    }

    public ResponseData setValue(String key, Object value) {
        data.put(key, value);
        return this;
    }

    private ResponseData(int errno, String errmsg) {
        this.errno = errno;
        this.errmsg = errmsg;
    }

    public static ResponseData ok() {
        return new ResponseData(0, "");
    }

    public static ResponseData notFound() {
        return new ResponseData(404, "Not Found");
    }

    public static ResponseData badRequest() {
        return new ResponseData(400, "Bad Request");
    }

    public static ResponseData forbidden() {
        return new ResponseData(403, "Forbidden");
    }

    public static ResponseData unauthorized() {
        return new ResponseData(401, "unauthorized");
    }

    public static ResponseData serverInternalError() {
        return new ResponseData(500, "Internal Server Error");
    }

    public static ResponseData customerError() {
        return new ResponseData(1001, "customer Error");
    }
}
