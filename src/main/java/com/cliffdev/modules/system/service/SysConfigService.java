package com.cliffdev.modules.system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cliffdev.modules.system.domain.SysConfig;
import com.cliffdev.modules.system.dto.SysConfigDTO;
import com.cliffdev.modules.system.mapper.SysConfigMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.beans.BeanCopier;
import org.springframework.stereotype.Service;

@Service
public class SysConfigService {

    @Autowired
    private SysConfigMapper configMapper;

    public SysConfigDTO get(String configKey) {
        QueryWrapper<SysConfig> qw = new QueryWrapper<>();
        qw.eq("config_key", configKey);
        qw.eq("del_flag", 0);
        SysConfig config = configMapper.selectOne(qw);
        BeanCopier beanCopier = BeanCopier.create(SysConfig.class, SysConfigDTO.class, false);
        if (config != null) {
            SysConfigDTO dto = new SysConfigDTO();
            beanCopier.copy(config, dto, null);
            return dto;
        }
        return null;
    }

    public boolean addOrUpdate(SysConfigDTO configDTO) {
        SysConfigDTO oldConfig  = get(configDTO.getConfigKey());
        BeanCopier beanCopier = BeanCopier.create(SysConfigDTO.class,SysConfig.class, false);
        SysConfig config = new SysConfig();
        beanCopier.copy(configDTO,config, null);
        if(oldConfig != null){
            configMapper.updateById(config);
        }else{
            configMapper.insert(config);
        }
        return true;
    }

}
