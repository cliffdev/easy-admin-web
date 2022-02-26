package com.cliffdev.modules.query.dto;

import lombok.Data;

import java.io.Serializable;

/**
 * @author huangzhijun
 */
@Data
public class EasyQueryTableReqDTO implements Serializable {

    private int pageIndex;

    private int pageSize;

    private String tableId;

    private String title;

}
