package com.cliffdev.modules.query.resource;

import com.cliffdev.modules.query.domain.EasyQueryColumn;
import com.cliffdev.modules.query.domain.EasyQueryTable;

/**
 * @author huangzhijun
 */
public abstract class AbstractQuerySqlParser  implements  QuerySqlParser {

    @Override
    public   String getTotalSql(String selectSql){
        StringBuilder totalSql = new StringBuilder();
        totalSql.append("select count(*) as cnt from ( " + selectSql + " ) _t");
        return totalSql.toString();
    }

    @Override
    public  String getPageListSql(EasyQueryTable queryTable, String selectSql){
        return selectSql +"  limit :offset , :count";
    }

    public  String getDictSql(EasyQueryColumn queryColumn) {
        return " select dict_label from easy_dict_data where dict_type = '"+queryColumn.getDict()+"' and dict_value = t."+queryColumn.getColumnName()+"  and status = 0 limit 1 ";
    }
    public  String getCustDictSql(EasyQueryColumn queryColumn) {
        return " select dict_label from ("+queryColumn.getDictSql()+") d where   dict_value = t."+queryColumn.getColumnName()+"  and status = 0 limit 1 ";
    }
}
