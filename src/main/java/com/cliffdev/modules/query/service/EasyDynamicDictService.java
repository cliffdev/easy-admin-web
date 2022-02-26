package com.cliffdev.modules.query.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cliffdev.config.SpringApplicationContextUtil;
import com.cliffdev.modules.query.domain.EasyDynamicDict;
import com.cliffdev.modules.query.dto.DictValueDTO;
import com.cliffdev.modules.query.mapper.EasyDynamicDictMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import javax.sql.DataSource;
import java.util.List;

@Service
public class EasyDynamicDictService {

    @Autowired
    private EasyDynamicDictMapper dynamicDictMapper;

    private EasyDynamicDict getDictInfo(String dictName){
        EasyDynamicDict dynamicDict = dynamicDictMapper.selectOne(
                new QueryWrapper<EasyDynamicDict>()
                        .eq("del_flag", 0).eq("dict_name",dictName));
        return dynamicDict;
    }

    public List<DictValueDTO> getDict(String dictName){
        EasyDynamicDict dict = getDictInfo(dictName);
        if(dict == null){
            return null;
        }
        DataSource ds = (DataSource) SpringApplicationContextUtil.getBean(dict.getDatasource());
        NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(ds);
        List<DictValueDTO> dictValueDTOList = jdbcTemplate.query(dict.getDictSql(), new BeanPropertyRowMapper<DictValueDTO>(DictValueDTO.class));
        return dictValueDTOList;
    }

}
