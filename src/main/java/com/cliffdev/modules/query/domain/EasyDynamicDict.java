package com.cliffdev.modules.query.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.math.BigInteger;
import java.util.Date;

@TableName("easy_dynamic_dict")
@Data
public class EasyDynamicDict implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    private BigInteger id;
    private String tag;
    private String dictName;
    private String dictSql;
    private String datasource;
    private String style;
    private String createBy;
    private Date createTime;
    private String updateBy;
    private Date updateTime;
    private Integer delFlag;
    private String remark;

}
