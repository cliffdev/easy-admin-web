package com.cliffdev.modules.query.dto;

import lombok.ToString;

import java.util.HashMap;

@ToString
public class SimpleQueryReqDTO extends HashMap {

    public int getPageIndex() {
        return Integer.parseInt(this.get("pageIndex").toString());
    }
    public int getPageSize() {
        return Integer.parseInt(this.get("pageSize").toString());
    }

    public String getOrderBy() {
        return this.get("orderBy") == null ? "" : this.get("orderBy").toString();
    }

    public String getOrderField() {
        return this.get("orderField") == null ? "" : this.get("orderField").toString();
    }

    public String getQueryTableId() {
        return this.get("queryTableId") == null ? "" : this.get("queryTableId").toString();
    }


}
