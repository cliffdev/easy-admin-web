package com.cliffdev.modules.query.resource;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.cliffdev.common.model.Pagination;
import com.cliffdev.common.model.R;
import com.cliffdev.config.SpringApplicationContextUtil;
import com.cliffdev.modules.query.domain.EasyDictData;
import com.cliffdev.modules.query.domain.EasyQueryColumn;
import com.cliffdev.modules.query.domain.EasyQueryField;
import com.cliffdev.modules.query.domain.EasyQueryTable;
import com.cliffdev.modules.query.dto.EasyQueryTableDTO;
import com.cliffdev.modules.query.dto.EasyQueryTableReqDTO;
import com.cliffdev.modules.query.dto.QueryReqDTO;
import com.cliffdev.modules.query.mapper.EasyDictDataMapper;
import com.cliffdev.modules.query.mapper.EasyQueryColumnMapper;
import com.cliffdev.modules.query.mapper.EasyQueryFieldMapper;
import com.cliffdev.modules.query.mapper.EasyQueryTableMapper;
import com.google.common.collect.Lists;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.beans.BeanCopier;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import javax.sql.DataSource;
import java.util.*;

@Slf4j
@Component
public class EasyQueryResource {

    @Autowired
    private EasyQueryTableMapper tableMapper;

    @Autowired
    private EasyQueryColumnMapper columnMapper;

    @Autowired
    private EasyQueryFieldMapper fieldMapper;

    @Autowired
    private EasyDictDataMapper dictDataMapper;


    public R<Boolean> add(EasyQueryTableDTO sysQueryTableDTO) {
        EasyQueryTable sysQueryTable = new EasyQueryTable();
        BeanCopier beanCopier = BeanCopier.create(EasyQueryTableDTO.class, EasyQueryTable.class, false);
        beanCopier.copy(sysQueryTableDTO, sysQueryTable, null);
        tableMapper.insert(sysQueryTable);

        for (EasyQueryTableDTO.EasyQueryColumnDTO item : sysQueryTableDTO.getQueryColumns()) {
            EasyQueryColumn column = new EasyQueryColumn();
            BeanCopier copier = BeanCopier.create(EasyQueryTableDTO.EasyQueryColumnDTO.class, EasyQueryColumn.class, false);
            copier.copy(item, column, null);
            columnMapper.insert(column);
        }

        for (EasyQueryTableDTO.EasyQueryFieldDTO item : sysQueryTableDTO.getQueryFields()) {
            EasyQueryField field = new EasyQueryField();
            BeanCopier copier = BeanCopier.create(EasyQueryTableDTO.EasyQueryFieldDTO.class, EasyQueryField.class, false);
            copier.copy(item, field, null);
            fieldMapper.insert(field);
        }
        return R.ok(true);
    }

    public R<Boolean> update(EasyQueryTableDTO easyQueryTableDTO) {
        //删除后重新添加
        tableMapper.updateFlag(easyQueryTableDTO.getTableId(), 1);
        columnMapper.updateFlag(easyQueryTableDTO.getTableId(), 1);
        fieldMapper.updateFlag(easyQueryTableDTO.getTableId(), 1);
        return add(easyQueryTableDTO);
    }


    public R<Pagination<EasyQueryTableDTO>> query(EasyQueryTableReqDTO queryTableReq) {
        R<Pagination<EasyQueryTableDTO>> result = R.ok();
        QueryWrapper<EasyQueryTable> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("del_flag", 0);

        if (!StringUtils.isEmpty(queryTableReq.getTableId())) {
            queryWrapper.like("table_id", "%" + queryTableReq.getTableId() + "%");
        }
        if (!StringUtils.isEmpty(queryTableReq.getTitle())) {
            queryWrapper.like("title", "%" + queryTableReq.getTitle() + "%");
        }

        IPage<EasyQueryTable> pageList = tableMapper.selectPage(new Page<>(queryTableReq.getPageIndex(), queryTableReq.getPageSize()), queryWrapper);
        Pagination<EasyQueryTableDTO> pagination = new Pagination();
        pagination.setPageSize(queryTableReq.getPageSize());
        pagination.setPageIndex(queryTableReq.getPageIndex());
        BeanCopier beanCopier = BeanCopier.create(EasyQueryTable.class, EasyQueryTableDTO.class, false);
        List<EasyQueryTableDTO> list = Lists.newArrayList();
        for (EasyQueryTable item : pageList.getRecords()) {
            EasyQueryTableDTO dto = new EasyQueryTableDTO();
            beanCopier.copy(item, dto, null);
            list.add(dto);
        }
        pagination.setTotal(pageList.getTotal());
        pagination.setData(list);
        result.setData(pagination);
        return result;
    }

    public EasyQueryTable getTableInfo(String tableId) {
        QueryWrapper<EasyQueryTable> sysQueryTableQueryWrapper = new QueryWrapper();
        sysQueryTableQueryWrapper.eq("table_id", tableId);
        sysQueryTableQueryWrapper.eq("del_flag", 0);
        EasyQueryTable queryTable = tableMapper.selectOne(sysQueryTableQueryWrapper);
        if (queryTable == null) {
            log.info("查询列表:{} 不存在! ", tableId);
            return queryTable;
        }

        QueryWrapper<EasyQueryColumn> queryColumnQueryWrapper = new QueryWrapper();
        queryColumnQueryWrapper.eq("table_id", tableId);
        List<EasyQueryColumn> columnList = columnMapper.selectList(queryColumnQueryWrapper);

        QueryWrapper<EasyQueryField> queryFieldQueryWrapper = new QueryWrapper();
        queryFieldQueryWrapper.eq("table_id", tableId);
        List<EasyQueryField> fieldList = fieldMapper.selectList(queryFieldQueryWrapper);

        queryTable.setQueryColumns(columnList);
        queryTable.setQueryFields(fieldList);

        for (EasyQueryField sysQueryField : fieldList) {
            if ("select".equals(sysQueryField.getFieldType())) {
                if (Objects.isNull(sysQueryField.getFieldValue())) {
                    continue;
                }
                // 下拉列表值设置
                QueryWrapper<EasyDictData> dict = new QueryWrapper();
                final List<Map<String, Object>> maps = dictDataMapper.selectMaps(dict.eq("dict_type", sysQueryField.getFieldValue()).select("dict_label", "dict_value"));
                List<Map<String, Object>> newList = new ArrayList<>();
                for (Map<String, Object> map : maps) {
                    // 修改key值，方便前端
                    Map<String, Object> newSelectMap = new HashMap<>();
                    for (Map.Entry<String, Object> m : map.entrySet()) {
                        if ("dict_label".equals(m.getKey())) {
                            newSelectMap.put("label", m.getValue());
                        }
                        if ("dict_value".equals(m.getKey())) {
                            newSelectMap.put("value", m.getValue());
                        }
                    }
                    newList.add(newSelectMap);
                }
                sysQueryField.setOptions(newList);
            }
        }
        return queryTable;
    }

    /**
     * 1:根据查询列表标识获取
     * 2:验证必要参数
     *
     * @param queryReq
     * @return
     */
    public Pagination<Map<String, Object>> query(QueryReqDTO queryReq) {
        Pagination<Map<String, Object>> pagination = new Pagination();
        try {
            pagination.setPageIndex(queryReq.getPageIndex());
            pagination.setPageSize(queryReq.getPageSize());
            EasyQueryTable queryTable = getTableInfo(queryReq.getQueryTableId());
            if (queryTable == null) {
                return pagination;
            }
            QuerySqlParser querySqlParser = QuerySqlParserFactory.getInstance(queryTable.getDataSourceType());
            String selectSql = querySqlParser.getSelectSql(queryTable, queryReq);
            String totalSql = querySqlParser.getTotalSql(selectSql);
            String pageListSql = querySqlParser.getPageListSql(queryTable, selectSql);
            DataSource ds = (DataSource) SpringApplicationContextUtil.getBean(queryTable.getDataSource());
            NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(ds);
            Map<String, Object> params = querySqlParser.getQueryParams(queryTable, queryReq);
            long total = jdbcTemplate.queryForObject(totalSql, params, Long.class);
            pagination.setTotal(total);
            params.put("offset", (queryReq.getPageIndex() - 1) * queryReq.getPageSize());
            params.put("count", queryReq.getPageSize());
            List<Map<String, Object>> list = jdbcTemplate.queryForList(pageListSql, params);
            pagination.setData(list);
        } catch (Exception ex) {
            throw new RuntimeException("执行查询异常", ex);
        }
        return pagination;
    }
}
