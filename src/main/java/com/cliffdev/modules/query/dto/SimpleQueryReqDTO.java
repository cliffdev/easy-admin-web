package com.cliffdev.modules.query.dto;

import lombok.ToString;

import java.util.HashMap;

@ToString
public class SimpleQueryReqDTO extends HashMap<String,String> {

    public int getPageIndex() {
        return Integer.parseInt(this.get("pageIndex"));
    }
    public int getPageSize() {
        return Integer.parseInt(this.get("pageSize"));
    }

    public String getOrderBy() {
        return this.get("orderBy");
    }

    public String getOrderField() {
        return this.get("orderField");
    }

    public String getQueryTableId() {
        return this.get("queryTableId");
    }

}
