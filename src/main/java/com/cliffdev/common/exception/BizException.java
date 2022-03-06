package com.cliffdev.common.exception;

import lombok.Data;
import lombok.ToString;

@ToString
@Data
public class BizException extends RuntimeException {

    private String msg;
    private int code;

    public BizException(int code,String msg){
        this.code = code;
        this.msg = msg;
    }

}
