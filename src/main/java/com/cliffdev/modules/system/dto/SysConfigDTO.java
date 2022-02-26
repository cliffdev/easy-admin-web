package com.cliffdev.modules.system.dto;

import lombok.Data;
import lombok.ToString;

import java.io.Serializable;
import java.util.Date;

@Data
@ToString
public class SysConfigDTO implements Serializable {

    private Integer configId;
    private String configName;
    private String configKey;
    private String configValue;
    private String configType;
    private String createBy;
    private String updateBy;
    private Date createTime;
    private Date updateTime;
    private String remark;
    private Integer delFlag;
}
