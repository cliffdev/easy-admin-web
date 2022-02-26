package com.cliffdev.modules.query.resource;

/***
 * @author huangzhijun
 */
public class QuerySqlParserFactory {

    private static final String MYSQL="mysql";

    /**
     * 根据数据源类型获取对应的解析器
     * @param dataSourceType
     * @return
     */
    public static QuerySqlParser getInstance(String dataSourceType){
        QuerySqlParser querySqlParser = null;
        if(MYSQL.equalsIgnoreCase(dataSourceType)){
            querySqlParser = new MySQLQuerySqlParser();
        }
        return querySqlParser;
    }
}
