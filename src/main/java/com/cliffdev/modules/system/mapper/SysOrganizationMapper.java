package com.cliffdev.modules.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cliffdev.modules.system.domain.SysOrganization;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface SysOrganizationMapper extends BaseMapper<SysOrganization> {

}
