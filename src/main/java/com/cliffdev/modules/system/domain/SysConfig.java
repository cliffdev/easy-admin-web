package com.cliffdev.modules.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

import java.util.Date;

@TableName("sys_config")
@Data
@ToString
public class SysConfig {

    private static final long serialVersionUID = 3562492581711167599L;
    @TableId(value = "config_id", type = IdType.AUTO)
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
