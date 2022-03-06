package com.cliffdev.modules.system.domain;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@TableName("sys_role_menu")
@Data
public class SysRoleMenu implements Serializable {

    private Long roleId;

    private Long menuId;

    @TableField(exist = false)
    private String menuName;

    @TableField(exist = false)
    private Integer parentId;

    @TableField(exist = false)
    private Integer orderNum;

    @TableField(exist = false)
    private String path;

    @TableField(exist = false)
    private String component;

    @TableField(exist = false)
    private String isFrame;

    @TableField(exist = false)
    private String menuType;

    @TableField(exist = false)
    private Integer visible;

    @TableField(exist = false)
    private Integer status;

    @TableField(exist = false)
    private String perms;

    @TableField(exist = false)
    private String icon;

//    @TableField(exist = false)
    private Integer sourceType;

    @TableField(exist = false)
    private String groupFlag;

    @TableField(exist = false)
    private String createBy;

    @TableField(exist = false)
    private String updateBy;

    @TableField(exist = false)
    private Date createTime;

    @TableField(exist = false)
    private Date updateTime;

    @TableField(exist = false)
    private String remark;

    @TableField(exist = false)
    private Integer delFlag;

}
