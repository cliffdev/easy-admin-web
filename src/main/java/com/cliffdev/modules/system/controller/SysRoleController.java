package com.cliffdev.modules.system.controller;

import com.cliffdev.common.model.R;
import com.cliffdev.modules.system.dto.SysRoleDTO;
import com.cliffdev.modules.system.service.SysRoleService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * @author huangzhijun
 */
@Api(tags = "角色管理")
@Slf4j
@Controller
@RequestMapping("/sys/role")
public class SysRoleController {

    @Autowired
    private SysRoleService service;

    @ApiOperation(value = "新增角色")
    @PostMapping()
    @ResponseBody
    public R<Boolean> post(@ApiParam("新增角色") @Validated @RequestBody SysRoleDTO sysRoleDto) {
        return R.result(service.add(sysRoleDto));
    }

    @ApiOperation(value = "删除角色")
    @DeleteMapping("{roleId}")
    @ResponseBody
    public R<Boolean> delete(@ApiParam("删除角色") @Validated  @PathVariable("roleId") Integer roleId) {
        return R.result(service.delete(roleId));
    }

    @ApiOperation(value = "更新角色")
    @PutMapping()
    @ResponseBody
    public R<Boolean> edit(@ApiParam("更新角色") @Validated @RequestBody SysRoleDTO sysRoleDto) {
        return R.result(service.update(sysRoleDto));
    }

}
