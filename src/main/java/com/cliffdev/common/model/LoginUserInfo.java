package com.cliffdev.common.model;

import lombok.Data;
import lombok.ToString;
import java.io.Serializable;
import java.util.Date;

@ToString
@Data
public class LoginUserInfo implements Serializable {

    //账号
    private String account;
    //登录时间
    private Date loginTime;
    //角色名称
    private String roleName;
    //用户类型
    private String accountType;
    //公司Id
    private String companyId;
    //公司名称
    private String compnayName;
    //部门ID
    private String dpetId;
    //部门名称
    private String deptName;
    //微信ID
    private String wxOpenId;
    //钉钉ID
    private String ddOpenId;
    //客户端类型
    private String clientType;

}
