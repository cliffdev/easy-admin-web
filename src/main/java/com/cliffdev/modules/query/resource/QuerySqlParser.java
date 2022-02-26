package com.cliffdev.modules.query.resource;

import com.cliffdev.modules.query.domain.EasyQueryTable;
import com.cliffdev.modules.query.dto.QueryReqDTO;

import java.util.Map;

/**
 * @author huangzhijun
 */
public interface QuerySqlParser {

    String getSelectSql(EasyQueryTable queryTable, QueryReqDTO queryReq);

    String getTotalSql(String selectSql);

    String getPageListSql(EasyQueryTable queryTable,String selectSql);

    Map<String,Object> getQueryParams(EasyQueryTable queryTable, QueryReqDTO queryReq);

}
