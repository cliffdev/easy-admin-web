package com.cliffdev.modules.query.controller;

import com.cliffdev.modules.query.dto.DictValueDTO;
import com.cliffdev.modules.query.service.EasyDynamicDictService;
import com.cliffdev.modules.query.service.EasyStaticDictService;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("dict")
public class EasyDictController {

    @Autowired
    private EasyDynamicDictService dynamicDictService;

    @Autowired
    private EasyStaticDictService staticDictService;

    @ApiOperation(value = "查询字典")
    @GetMapping("dynamic/{theme}/{dictName}")
    @ResponseBody
    public List<Map<String, Object>> getDynamicDict(HttpServletRequest request, @ApiParam("字典名称") @Validated @PathVariable String dictName, @ApiParam("主题") @Validated @PathVariable String theme) throws Exception {
        return getDynamicDict(dictName, theme);
    }

    @ApiOperation(value = "查询字典")
    @GetMapping("static/{theme}/{dictName}")
    @ResponseBody
    public List<Map<String, Object>> getStaticDict(HttpServletRequest request, @ApiParam("字典名称") @Validated @PathVariable String dictName, @ApiParam("主题") @Validated @PathVariable String theme) throws Exception {
        return getStaticDict(dictName, theme);
    }

    private List<Map<String, Object>> getDynamicDict(String dictName, String theme) {
        List<DictValueDTO> dictValueDTOList = dynamicDictService.getDict(dictName);
        List<Map<String, Object>> newList = new ArrayList<>();
        for (DictValueDTO item : dictValueDTOList) {
            Map<String, Object> map = new HashMap<>();
            if (StringUtils.isEmpty(theme)) {
                map.put("dictLable", item.getId());
                map.put("dictValue", item.getText());
            } else if ("el".equalsIgnoreCase(theme)) {
                map.put("lable", item.getId());
                map.put("value", item.getText());
            } else if ("easyui".equalsIgnoreCase(theme)) {
                map.put("id", item.getId());
                map.put("text", item.getText());
            }
            newList.add(map);
        }
        return newList;
    }

    private List<Map<String, Object>> getStaticDict(String dictName, String theme) {
        List<DictValueDTO> dictValueDTOList = staticDictService.getDict(dictName);
        List<Map<String, Object>> newList = new ArrayList<>();
        for (DictValueDTO item : dictValueDTOList) {
            Map<String, Object> map = new HashMap<>();
            if (StringUtils.isEmpty(theme)) {
                map.put("dictLable", item.getId());
                map.put("dictValue", item.getText());
            } else if ("el".equalsIgnoreCase(theme)) {
                map.put("lable", item.getId());
                map.put("value", item.getText());
            } else if ("easyui".equalsIgnoreCase(theme)) {
                map.put("id", item.getId());
                map.put("text", item.getText());
            }
            newList.add(map);
        }
        return newList;
    }

}
