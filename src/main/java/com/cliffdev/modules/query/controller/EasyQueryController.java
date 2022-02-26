package com.cliffdev.modules.query.controller;

import com.cliffdev.common.model.Pagination;
import com.cliffdev.common.model.R;
import com.cliffdev.modules.query.dto.QueryReqDTO;
import com.cliffdev.modules.query.dto.SimpleQueryReqDTO;
import com.cliffdev.modules.query.service.EasyQueryService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.util.Map;
@RestController
@RequestMapping("query")
public class EasyQueryController {

    @Autowired
    private EasyQueryService easyQueryService;

    @ApiOperation(value = "查询")
    @PostMapping("/selectList")
    @ResponseBody
    public R<Pagination<Map<String, Object>>> query(HttpServletRequest request, @ApiParam("查询参数") @RequestBody QueryReqDTO queryReq) throws Exception {
        //queryReq.setQueryTableId(tableId);
        //queryReq.setEnvParams(getEnvParams());
        Pagination<Map<String, Object>> pagination = easyQueryService.query(queryReq);
        return R.ok(pagination);
    }
    @ApiOperation(value = "查询")
    @PostMapping("/simple/selectList")
    @ResponseBody
    public R<Pagination<Map<String, Object>>> simpleQuery(HttpServletRequest request, @ApiParam("查询参数") @RequestBody SimpleQueryReqDTO simpleQueryReqDTO) throws Exception {
        //queryReq.setQueryTableId(tableId);
        //queryReq.setEnvParams(getEnvParams());
        Pagination<Map<String, Object>> pagination = easyQueryService.query(simpleQueryReqDTO);
        if(pagination != null) {
            return R.ok(pagination);
        }
        return R.fail();
    }
}
