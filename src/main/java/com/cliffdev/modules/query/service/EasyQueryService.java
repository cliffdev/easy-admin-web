package com.cliffdev.modules.query.service;

import com.cliffdev.common.model.Pagination;
import com.cliffdev.common.model.R;
import com.cliffdev.modules.query.dto.EasyQueryTableDTO;
import com.cliffdev.modules.query.dto.EasyQueryTableReqDTO;
import com.cliffdev.modules.query.dto.QueryReqDTO;
import com.cliffdev.modules.query.resource.EasyQueryResource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * @author huangzhijun
 */
@Slf4j
@Service
public class EasyQueryService {

    private static  final int MAX_PAGE_SIZE = 10000;

    @Autowired
    private EasyQueryResource easyQueryResource;

    public R<Pagination<Map<String, Object>>> query(QueryReqDTO queryReq) {
        if(queryReq.getPageIndex() < 1){
            queryReq.setPageIndex(1);
        }
        if(queryReq.getPageSize() > MAX_PAGE_SIZE){
            queryReq.setPageSize(MAX_PAGE_SIZE);
        }
        if(queryReq.getPageSize() < 1){
            queryReq.setPageSize(1);
        }
        R<Pagination<Map<String, Object>>> result = R.ok();
        Pagination<Map<String, Object>> pagination = easyQueryResource.query(queryReq);
        result.setData(pagination);
        return result;
    }

    public R<Pagination<EasyQueryTableDTO>> query(EasyQueryTableReqDTO queryReq) {
        if(queryReq.getPageIndex() < 1){
            queryReq.setPageIndex(1);
        }
        if(queryReq.getPageSize() > MAX_PAGE_SIZE){
            queryReq.setPageSize(MAX_PAGE_SIZE);
        }
        if(queryReq.getPageSize() < 1){
            queryReq.setPageSize(1);
        }
        return easyQueryResource.query(queryReq);
    }

//    public R<EasyQueryTableDTO> getQueryInfo(String tableId) {
//        R<EasyQueryTableDTO> result = R.fail();
//        EasyQueryTable queryTable = easyQueryResource.getTableInfo(tableId);
//        String pageList = queryTable.getPageList();
//        String[] split = pageList.split(",");
//        List<String> list = new ArrayList<>(Arrays.asList(split));
//        List<Integer> list1 = new ArrayList<>();
//        for (int i = 0; i < list.size(); i++) {
//            list1.add(Integer.parseInt(list.get(i)));
//        }
//        if(queryTable != null) {
//            BeanCopier beanCopier = BeanCopier.create(EasyQueryTable.class, EasyQueryTableDTO.class, false);
//            EasyQueryTableDTO dto = new EasyQueryTableDTO();
//            beanCopier.copy(queryTable,dto,null);
//            dto.setPageList(list1);
//            result = R.ok(dto);
//        }
//        return result;
//    }
}
