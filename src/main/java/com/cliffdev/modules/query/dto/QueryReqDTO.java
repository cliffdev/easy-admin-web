package com.cliffdev.modules.query.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

/**
 * @author huangzhijun
 */
@Data
public class QueryReqDTO implements Serializable {

    private int pageIndex;

    private int pageSize;

    private String orderBy;

    private String orderField;

    private String queryTableId;

    private List<QueryField> queryFieldList;

    private Map<String,Object> envParams;

    @Data
    public static class QueryField implements Serializable{
        private String field;
        private String value1;
        private String value2;
    }
}
