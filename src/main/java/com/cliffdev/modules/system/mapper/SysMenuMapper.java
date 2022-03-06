package com.cliffdev.modules.system.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.cliffdev.modules.system.domain.SysMenu;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author huangzhijun
 */
@Mapper
public interface SysMenuMapper extends BaseMapper<SysMenu> {

    /**
     * 根据用户查询系统菜单列表
     * @return 菜单列表
     */
    public List<SysMenu> selectMenuListByUserId(@Param(Constants.WRAPPER) Wrapper wrapper);

    /**
     * 根据用户ID查询权限
     * @return 权限列表
     */
    public List<Integer> selectMenuPermsByUserId(@Param(Constants.WRAPPER) Wrapper wrapper);
}
