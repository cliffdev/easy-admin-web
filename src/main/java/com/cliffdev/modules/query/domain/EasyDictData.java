package com.cliffdev.modules.query.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author huangzhijun
 */
@TableName("easy_dict_data")
@Data
public class EasyDictData implements Serializable {

    @TableId(value = "dict_code", type = IdType.AUTO)
    private Integer dictCode;
    private Integer dictSort;
    private String dictLabel;
    private String dictValue;
    private String dictType;
    private String isDefault;
    private String createBy;
    private String updateBy;
    private Date createTime;
    private Date updateTime;
    private String remark;
    private Integer status;
    private Integer delFlag;
}
