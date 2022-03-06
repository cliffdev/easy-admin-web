package com.cliffdev.modules.system.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author huangzhijun
 */
@TableName("sys_menu")
@Data
public class SysMenu implements Serializable {

    @TableId(value = "menu_id", type = IdType.AUTO)
    private Integer menuId;
    private String menuName;
    private Integer parentId;
    private Integer orderNum;
    private String path;
    private String component;
    private String isFrame;
    private String menuType;
    private Integer visible;
    private Integer status;
    private String perms;
    private String icon;
    private Integer sourceType;
    private String groupFlag;
    private String createBy;
    private String updateBy;
    @TableField(fill = FieldFill.DEFAULT)
    private Date createTime;
    @TableField(fill = FieldFill.DEFAULT)
    private Date updateTime;
    private String remark;
    private Integer delFlag;
    private Integer isLog;
}

