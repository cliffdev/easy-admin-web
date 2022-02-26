package com.cliffdev.common.model;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class Pagination<T> implements Serializable {
    private int pageIndex;
    private int pageSize;
    private long total;
    private List<T> data;

    public Pagination() {

    }

    public static Pagination getInstance() {
        return new Pagination();
    }
}
