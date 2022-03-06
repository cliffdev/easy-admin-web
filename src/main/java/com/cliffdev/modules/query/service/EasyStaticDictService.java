package com.cliffdev.modules.query.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cliffdev.modules.query.domain.EasyDictData;
import com.cliffdev.modules.query.dto.DictValueDTO;
import com.cliffdev.modules.query.mapper.EasyDictDataMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EasyStaticDictService {

    @Autowired
    private EasyDictDataMapper dictDataMapper;

    public List<DictValueDTO> getDict(String dictName) {
        QueryWrapper<EasyDictData> qw = new QueryWrapper<>();
        qw.eq("del_flag", 0).eq("dict_type", dictName).eq("status", 0).orderByAsc("dict_sort");
        List<EasyDictData> easyDictDataList = dictDataMapper.selectList(qw);
        List<DictValueDTO> dictValueDTOList = new ArrayList<>();
        for (EasyDictData item : easyDictDataList) {
            DictValueDTO dto = new DictValueDTO();
            dto.setId(item.getDictValue());
            dto.setText(item.getDictLabel());
            dictValueDTOList.add(dto);
        }
        return dictValueDTOList;
    }

}
