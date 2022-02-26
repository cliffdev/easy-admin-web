package com.cliffdev.modules.query.dto;

import lombok.Data;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

@ToString
@Data
public class EasyQueryTableConfigDTO implements Serializable {

    private String tableId;

    private String title;

    private String pagination;

    private List<Integer> pageList;

    private String status;

    private List<QueryColumnDTO> queryColumns;

    private List<QueryFieldDTO> queryFields;

    @Data
    public static class  QueryColumnDTO  implements Serializable {
        private String columnName;
        private String columnType;
        private String title;
        private Integer hidden;
        private Integer sortNum;
        private Integer primaryKey;
        private Integer width;
    }
    @Data
    public static class  QueryFieldDTO  implements Serializable {
        private String columnName;
        private String columnType;
    }
}
