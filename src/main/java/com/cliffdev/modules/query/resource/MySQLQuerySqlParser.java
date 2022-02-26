package com.cliffdev.modules.query.resource;

import com.cliffdev.modules.query.domain.EasyQueryColumn;
import com.cliffdev.modules.query.domain.EasyQueryField;
import com.cliffdev.modules.query.domain.EasyQueryTable;
import com.cliffdev.modules.query.dto.QueryReqDTO;
import com.cliffdev.modules.query.util.ColumnType;
import com.cliffdev.modules.query.util.QueryMode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StringUtils;
import java.util.HashMap;
import java.util.Map;

/**
 * @author huangzhijun
 */
@Slf4j
public class MySQLQuerySqlParser extends AbstractQuerySqlParser  implements QuerySqlParser{

    private static final String ASC="ASC";

    @Override
    public  String getSelectSql(EasyQueryTable queryTable, QueryReqDTO queryReq){
        StringBuilder selectSql = new StringBuilder();
        //1.基础查询sql
        selectSql.append("select ");
        int columnSize = queryTable.getQueryColumns().size();
        for (int i = 0; i < columnSize - 1; i++) {
            EasyQueryColumn queryColumn = queryTable.getQueryColumns().get(i);
            String queryColumnName = getQueryColumnName(queryColumn);
            selectSql.append(queryColumnName+",");
        }
        selectSql.append(getQueryColumnName(queryTable.getQueryColumns().get(columnSize-1)));

        if("1".equalsIgnoreCase(queryTable.getTableType())) {
            selectSql.append(" from  " + queryTable.getTableName() + " t ");
        }else{
            selectSql.append(" from  (" + queryTable.getTableName() + ") t ");
        }

        // 日期子查询
        String subQuery = "";
        //2 添加条件查询
        StringBuilder whereSql = new StringBuilder();
        if(queryReq.getQueryFieldList() != null ){
            whereSql.append(" where 1=1 ");
            for(QueryReqDTO.QueryField item :queryReq.getQueryFieldList()){
                if(StringUtils.isEmpty(item.getValue1()) && StringUtils.isEmpty(item.getValue2())){
                    continue;
                }
                EasyQueryField queryField = queryTable.getQueryField(item.getField());
                if(queryField == null){
                    continue;
                }
                if ("sub_query".equals(queryField.getQueryMode())) {
                    subQuery = " from ("+queryTable.getTableName().replace("[]",item.getValue1())+") t ";
                }

                if(QueryMode.eq.name().equalsIgnoreCase(queryField.getQueryMode())){
                    whereSql.append(" and " +queryField.getName() +" = :" + item.getField());
                }
                if(QueryMode.between.name().equalsIgnoreCase(queryField.getQueryMode())){
                    if(!StringUtils.isEmpty(item.getValue1())){
                        whereSql.append(" and " +queryField.getName() +">= :" + item.getField() +"1");
                    }
                    if(!StringUtils.isEmpty(item.getValue2())){
                        whereSql.append(" and " +queryField.getName() +"<= :" + item.getField() +"2");
                    }
                }
                if(QueryMode.like.name().equalsIgnoreCase(queryField.getQueryMode())){
                    String [] arr = queryField.getName().split(",");
                    whereSql.append(" and (");
                    for(int i= 0;i<arr.length-1 ;i++) {
                        whereSql.append( arr[i]+"  like :" + item.getField() +" or ");
                    }
                    whereSql.append( arr[arr.length-1]+"  like :" + item.getField() +" ");
                    whereSql.append(")");
                }
            }
        }
        if ("sub_query".equals(queryTable.getTableType())) {
            if (!StringUtils.isEmpty(subQuery)) {
                selectSql.append(subQuery);
            }else {
                selectSql.append( " from ("+queryTable.getTableName().replace("[]","8760")+") t ");
            }
        }

        selectSql.append(whereSql);

        //3.设置排序
        if(!StringUtils.isEmpty(queryReq.getOrderBy()) && !StringUtils.isEmpty(queryReq.getOrderField())
           && queryTable.hasQueryColumn(queryReq.getOrderField())){
            if(ASC.equalsIgnoreCase(queryReq.getOrderBy())){
                selectSql.append(" order by  "+queryReq.getOrderField()+" asc");
            }else{
                selectSql.append(" order by  "+queryReq.getOrderField() +" desc ");
            }
        }
        log.info("query sql:{}",selectSql.toString());
        return selectSql.toString();
    }

    @Override
    public Map<String,Object> getQueryParams(EasyQueryTable queryTable, QueryReqDTO queryReq){
        Map<String,Object> params = new HashMap<>();
        if(queryReq.getQueryFieldList() != null ){
            for(QueryReqDTO.QueryField item :queryReq.getQueryFieldList()){
                if(StringUtils.isEmpty(item.getValue1()) && StringUtils.isEmpty(item.getValue2())){
                    continue;
                }
                EasyQueryField queryField = queryTable.getQueryField(item.getField());
                if(queryField == null){
                    continue;
                }

                if(QueryMode.eq.name().equalsIgnoreCase(queryField.getQueryMode())){
                    params.put(item.getField(),item.getValue1());
                }

                if(QueryMode.between.name().equalsIgnoreCase(queryField.getQueryMode())){
                    if(!StringUtils.isEmpty(item.getValue1())){
                        params.put(item.getField()+"1",item.getValue1());
                    }
                    if(!StringUtils.isEmpty(item.getValue2())){
                        params.put(item.getField()+"2",item.getValue2());
                    }
                }
                if(QueryMode.like.name().equalsIgnoreCase(queryField.getQueryMode())){
                    params.put(item.getField(),"%"+item.getValue1()+"%");
                }
            }
        }
        if(queryReq.getEnvParams() != null) {
            params.putAll(queryReq.getEnvParams());
        }
        return params;
    }
    private   String getQueryColumnName(EasyQueryColumn queryColumn){
        if(StringUtils.isEmpty(queryColumn.getDict())) {
            if (ColumnType.DATE.name().equalsIgnoreCase(queryColumn.getColumnType())) {
                return "DATE_FORMAT(" + queryColumn.getColumnName() + ",'" + queryColumn.getFormatter() + "')  "+" as "+ queryColumn.getColumnName();
            } else if (ColumnType.TIME.name().equalsIgnoreCase(queryColumn.getColumnType())) {
                return "DATE_FORMAT(" + queryColumn.getColumnName() + ",'" + queryColumn.getFormatter() + "')  "+" as "+ queryColumn.getColumnName();
            } else {
                return queryColumn.getColumnName() ;
            }
        }else{
            if(StringUtils.isEmpty(queryColumn.getDictSql())) {
                return  "("+getDictSql(queryColumn)+")" +" as "+ queryColumn.getColumnName();
            }else{
                return "("+getCustDictSql(queryColumn)+")" +" as "+ queryColumn.getColumnName();
            }
        }
    }

}
