package com.cliffdev.modules.query.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @author huangzhijun
 */
@TableName("easy_query_field")
@Data
public class EasyQueryField implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String tableId;

    /**
     * 字段名称
     *
     */
    @TableField("field_name")
    private String label;

    /**
     * 字段类型
     * text 文本框
     * date 日期
     * time 时间
     * select 下拉框
     * tree 树
     */
    private String fieldType;

    /**
     *查询模式
     * like
     */
    private String queryMode;

    private String dict;

    /**
     * 查询默认值
     */
    private String fieldValue;

    private List<Map<String, Object>> options;

    private String dictSql;

    /**
     * 绑定的查询显示列,多个以逗号隔开
     */
    @TableField("column_list")
    private String name;
    /**
     * 是否隐藏
     */
    private Integer hidden;
}
