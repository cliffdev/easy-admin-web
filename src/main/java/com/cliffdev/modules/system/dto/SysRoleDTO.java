package com.cliffdev.modules.system.dto;


import com.fasterxml.jackson.annotation.JsonFormat;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author huangzhijun
 */
@ApiModel("角色model")
@Data
public class SysRoleDTO implements Serializable {

    @ApiModelProperty("角色id")
    private Integer id;

    @ApiModelProperty("角色名称")
    private String name;

    @ApiModelProperty("角色权限字符串")
    private String roleKey;

    @ApiModelProperty("排序号")
    private Integer sortNum;

    @ApiModelProperty("状态0正常 1停用）")
    private Integer status;

    @ApiModelProperty("是否内置 1:是，0否")
    private String isDefault;

    @ApiModelProperty("创建者")
    private String createBy;

    @ApiModelProperty("更新者")
    private String updateBy;

    @ApiModelProperty("创建时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    @ApiModelProperty("更新时间")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;

    @ApiModelProperty("备注")
    private String remark;

    @ApiModelProperty("0代表存在 1代表删除")
    private Integer delFlag;
    @ApiModelProperty("数据权限范围")
    private Integer dataScope;
}
