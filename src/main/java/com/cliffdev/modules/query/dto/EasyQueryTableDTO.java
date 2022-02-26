package com.cliffdev.modules.query.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @author huangzhijun
 */
@Data
public class EasyQueryTableDTO implements Serializable {

    private String id;

    private String tableId;

    private String tableName;

    private String tableType;

    private String dataSourceType;

    private String dataSource;

    private String pagination;

    private String pageList;

    private String status;

    private Integer delFlag;

    private List<EasyQueryColumnDTO> queryColumns;

    private List<EasyQueryFieldDTO> queryFields;

    @Data
    public static class EasyQueryColumnDTO implements Serializable{

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
        private Integer primaryKey;
    }

    @Data
    public static class EasyQueryFieldDTO implements Serializable{

        private Integer id;

        private String tableId;

        /**
         * 字段名称
         *
         */
        private String fieldName;

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

        private String dictSql;

        /**
         * 绑定的查询显示列,多个以逗号隔开
         */
        private String columnList;
    }
}
