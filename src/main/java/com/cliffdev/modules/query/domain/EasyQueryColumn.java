package com.cliffdev.modules.query.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * @author huangzhijun
 */
@TableName("easy_query_column")
@Data
public class EasyQueryColumn implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private String tableId;
    private String columnName;
    /**
     * 字段类型
     * text 文本框
     * date 日期
     * time 时间
     */
    private String columnType;
    private String formatter;
    private String dict;
    private String dictSql;
    private String title;
    /**
     * 排序
     */
    private Integer sortNum;
    /**
     * 是否隐藏
     */
    private Integer hidden;

    //是否主键
    private Integer primaryKey;
    /**
     * 宽度
     */
    private Integer width;
}
