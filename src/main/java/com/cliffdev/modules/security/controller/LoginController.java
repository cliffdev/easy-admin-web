package com.cliffdev.modules.security.controller;

import com.cliffdev.common.model.LoginUserInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@Controller
public class LoginController {

    @RequestMapping("/logout.html")
    public String logout(HttpServletRequest req) {
        req.getSession().removeAttribute("loginUserSessionKey");
        req.getSession().removeAttribute("loginName");
        return "login";
    }

    @RequestMapping(value="/doLogin",method= RequestMethod.POST)
    @ResponseBody
    public String doLogin(HttpServletRequest req, String login, String password,String captcha) {
        LoginUserInfo loginUserInfo = new LoginUserInfo();
        loginUserInfo.setAccount(login);
        loginUserInfo.setLoginTime(new Date());
        req.getSession().setAttribute("loginUserSessionKey",loginUserInfo);
        return "success";
    }
}
