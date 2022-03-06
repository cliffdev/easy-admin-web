package com.cliffdev.modules.security.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
public class AdminWebController {

    @RequestMapping("/")
    public String home(HttpServletRequest req) {
        return  routeIndex(req);
    }

    @RequestMapping("/index")
    public String index(HttpServletRequest req) {
        return  routeIndex(req);
    }

    @RequestMapping("/index.html")
    public String indexHtml(HttpServletRequest req) {
        return  routeIndex(req);
    }
    @RequestMapping("/admin/index")
    public String adminIndex(HttpServletRequest req) {
        return  routeIndex(req);
    }

    private String routeIndex(HttpServletRequest req){
        return "index";
    }
}
