package com.cliffdev.modules.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author huangzhijun
 */
@TableName("sys_role")
@Data
public class SysRole implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private String name;
    private String roleKey;
    private Integer sortNum;
    private String isDefault;
    private String createBy;
    private String updateBy;
    private Date createTime;
    private Date updateTime;
    private String remark;
    private Integer status;
    private Integer delFlag;
    private Integer dataScope;
}
