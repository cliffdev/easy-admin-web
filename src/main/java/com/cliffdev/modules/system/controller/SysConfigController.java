package com.cliffdev.modules.system.controller;

import com.cliffdev.common.model.R;
import com.cliffdev.modules.system.dto.SysConfigDTO;
import com.cliffdev.modules.system.service.SysConfigService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("sys/config")
public class SysConfigController {

    @Autowired
    private SysConfigService configService;

    @ApiOperation(value = "查询系统配置")
    @GetMapping("{configKey}")
    @ResponseBody
    public R<SysConfigDTO> get(HttpServletRequest request, @ApiParam("configKey") @Validated @PathVariable String configKey) throws Exception {
        return R.ok(configService.get(configKey));
    }

    @ApiOperation(value = "新增或修改系统配置")
    @PostMapping("{configKey}")
    @ResponseBody
    public R addOrUpdate(HttpServletRequest request, @RequestBody SysConfigDTO configDTO, @ApiParam("configKey") @Validated @PathVariable String configKey) throws Exception {
        configDTO.setConfigKey(configKey);
        boolean flag = configService.addOrUpdate(configDTO);
        if (flag) {
            return R.ok();
        }
        return R.fail("操作失败");
    }

}
