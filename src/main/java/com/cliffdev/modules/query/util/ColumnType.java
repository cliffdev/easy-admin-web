package com.cliffdev.modules.query.util;

/**
 * @author huangzhijun
 */
public enum ColumnType {

    TEXT("text","文本"),
    DATE("date","日期"),
    TIME("time","时间"),
    NUMBER("number","数值");
    private String name;
    private String desc;

    private ColumnType(String name, String desc){
        this.name = name;
        this.desc = desc;
    }
}
