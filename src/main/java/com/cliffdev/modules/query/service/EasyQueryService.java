package com.cliffdev.modules.query.service;

import com.cliffdev.common.model.Pagination;
import com.cliffdev.common.model.R;
import com.cliffdev.modules.query.domain.EasyQueryField;
import com.cliffdev.modules.query.domain.EasyQueryTable;
import com.cliffdev.modules.query.dto.*;
import com.cliffdev.modules.query.resource.EasyQueryResource;
import com.google.common.base.CaseFormat;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.beans.BeanCopier;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * @author huangzhijun
 */
@Slf4j
@Service
public class EasyQueryService {

    private static final int MAX_PAGE_SIZE = 10000;

    @Autowired
    private EasyQueryResource easyQueryResource;

    public Pagination<Map<String, Object>> query(SimpleQueryReqDTO simpleQueryReqDTO) {
        QueryReqDTO queryReqDTO = new QueryReqDTO();
        queryReqDTO.setPageIndex(simpleQueryReqDTO.getPageIndex());
        queryReqDTO.setPageSize(simpleQueryReqDTO.getPageSize());
        queryReqDTO.setQueryTableId(simpleQueryReqDTO.getQueryTableId());
        queryReqDTO.setOrderBy(simpleQueryReqDTO.getOrderBy());
        queryReqDTO.setOrderField(simpleQueryReqDTO.getOrderField());
        EasyQueryTable queryTable = easyQueryResource.getTableInfo(simpleQueryReqDTO.getQueryTableId());
        if (queryTable == null) {
            log.info("查询列表:{}不存在", simpleQueryReqDTO.getQueryTableId());
            return null;
        }
        List<QueryReqDTO.QueryField> queryFieldList = new ArrayList<>();
        for (EasyQueryField item : queryTable.getQueryFields()) {
            Object value = simpleQueryReqDTO.get(item.getLabel());
            if (value != null) {
                QueryReqDTO.QueryField searchField = new QueryReqDTO.QueryField();
                searchField.setField(item.getLabel());
                searchField.setValue1(value.toString());
                queryFieldList.add(searchField);
            }
        }
        queryReqDTO.setQueryFieldList(queryFieldList);
        return query(queryReqDTO);
    }

    public Pagination<Map<String, Object>> query(QueryReqDTO queryReq) {
        if (queryReq.getPageIndex() < 1) {
            queryReq.setPageIndex(1);
        }
        if (queryReq.getPageSize() > MAX_PAGE_SIZE) {
            queryReq.setPageSize(MAX_PAGE_SIZE);
        }
        if (queryReq.getPageSize() < 1) {
            queryReq.setPageSize(1);
        }

        Pagination<Map<String, Object>> pagination = easyQueryResource.query(queryReq);
        List<Map<String, Object>> list = pagination.getData();
        List<Map<String, Object>> newList = new ArrayList<>();
        for (Map<String, Object> item : list) {
            Map<String, Object> newMap = new HashMap<>();
            Iterator<String> ite = item.keySet().iterator();
            while (ite.hasNext()) {
                String key = ite.next();
                String name = CaseFormat.LOWER_UNDERSCORE.to(CaseFormat.LOWER_CAMEL, key);
                newMap.put(name, item.get(key));
            }
            newList.add(newMap);
        }
        pagination.setData(newList);
        return pagination;
    }

    public  Pagination<EasyQueryTableDTO> query(EasyQueryTableReqDTO queryReq) {
        if (queryReq.getPageIndex() < 1) {
            queryReq.setPageIndex(1);
        }
        if (queryReq.getPageSize() > MAX_PAGE_SIZE) {
            queryReq.setPageSize(MAX_PAGE_SIZE);
        }
        if (queryReq.getPageSize() < 1) {
            queryReq.setPageSize(1);
        }
        return easyQueryResource.query(queryReq);
    }

    public R<EasyQueryTableConfigDTO> getQueryInfo(String tableId) {
        R<EasyQueryTableConfigDTO> result = R.fail();
        EasyQueryTable queryTable = easyQueryResource.getTableInfo(tableId);
        String pageList = queryTable.getPageList();
        String[] split = pageList.split(",");
        List<String> list = new ArrayList<>(Arrays.asList(split));
        List<Integer> list1 = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            list1.add(Integer.parseInt(list.get(i)));
        }
        if (queryTable != null) {
            BeanCopier beanCopier = BeanCopier.create(EasyQueryTable.class, EasyQueryTableConfigDTO.class, false);
            EasyQueryTableConfigDTO dto = new EasyQueryTableConfigDTO();
            beanCopier.copy(queryTable, dto, null);
            dto.setPageList(list1);
            result = R.ok(dto);
        }
        return result;
    }
}
