package com.cliffdev.modules.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cliffdev.modules.system.domain.SysEmployee;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * @author: LaiZhiShen
 * @Description
 * @Date 2021-03-02 19:04
 */
@Mapper
public interface SysEmployeeMapper extends BaseMapper<SysEmployee> {

}
