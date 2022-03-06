package com.cliffdev.modules.system.service;

import com.cliffdev.common.exception.BizException;
import com.cliffdev.modules.system.domain.SysRole;
import com.cliffdev.modules.system.dto.SysRoleDTO;
import com.cliffdev.modules.system.mapper.SysRoleMapper;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.beans.BeanCopier;
import org.springframework.stereotype.Service;

/**
 * @author huangzhijun
 */
@Service
@Slf4j
public class SysRoleService {

    private static final String SYSTEM_ROLE_FLAG="1";
    @Autowired
    private SysRoleMapper roleMapper;

    public boolean add(SysRoleDTO sysRoleDto) {
        SysRole newRole = new SysRole();
        BeanCopier beanCopier = BeanCopier.create(SysRoleDTO.class, SysRole.class, false);
        beanCopier.copy(sysRoleDto, newRole, null);
        roleMapper.insert(newRole);
        return true;
    }

    public boolean update(SysRoleDTO sysRoleDto) {
        SysRole updateRole = new SysRole();
        BeanCopier beanCopier = BeanCopier.create(SysRoleDTO.class, SysRole.class, false);
        beanCopier.copy(sysRoleDto, updateRole, null);
        roleMapper.updateById(updateRole);
        return true;
    }

    public boolean delete(Integer roleId) {
        SysRole sysRole = roleMapper.selectById(roleId);
        if (sysRole != null) {
            if(SYSTEM_ROLE_FLAG.equals(sysRole.getIsDefault())){
                   throw new BizException(500,"系统内部角色不可删除");
            }
            sysRole.setDelFlag(1);
            roleMapper.updateById(sysRole);
            return true;
        }
        throw new BizException(500,"角色不存在");
    }

}
