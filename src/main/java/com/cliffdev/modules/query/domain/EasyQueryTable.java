package com.cliffdev.modules.query.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * @author huangzhijun
 */
@TableName("easy_query_table")
@Data
public class EasyQueryTable implements Serializable {

    @TableId(value = "id", type = IdType.INPUT)
    private String id;

    private String title;

    private String tableId;

    private String tableName;

    private String tableType;

    private String dataSourceType;

    private String dataSource;

    private String pagination;

    private String pageList;

    private String status;

    private Integer delFlag;

    @TableField(exist = false)
    private List<EasyQueryColumn> queryColumns;

    @TableField(exist = false)
    private List<EasyQueryField> queryFields;


    public EasyQueryField getQueryField(String fieldName){
        if(queryFields ==null || queryFields.size() <1){
            return null;
        }
        for(EasyQueryField item :queryFields){
            if(item.getName().equalsIgnoreCase(fieldName)){
                return item;
            }
        }
        return null;
    }
    public boolean hasQueryColumn(String columnName){
        if(queryColumns ==null || queryColumns.size() <1){
            return false;
        }
        for(EasyQueryColumn item :queryColumns){
            if(item.getColumnName().equalsIgnoreCase(columnName)){
                return true;
            }
        }
        return false;
    }

}
