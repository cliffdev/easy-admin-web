package com.cliffdev.common.exception;

import com.cliffdev.common.model.R;
import com.google.gson.Gson;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    Gson gson = new Gson();

    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public R exceptionHandler(Exception e){
        R result = R.fail();
        result.setMsg(e.getMessage());
        log.error("未知异常！原因是:",e);
        if(e instanceof  BizException){
            BizException bizException = (BizException)e;
            result.setCode(bizException.getCode());
            result.setMsg(bizException.getMsg());
        }
        return result;
    }
}
