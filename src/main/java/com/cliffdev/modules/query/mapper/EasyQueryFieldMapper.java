package com.cliffdev.modules.query.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cliffdev.modules.query.domain.EasyQueryField;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

/**
 * @author huangzhijun
 */
@Mapper
public interface EasyQueryFieldMapper extends BaseMapper<EasyQueryField> {

    @Update("UPDATE sys_query_field SET del_flag = #{delFlag} WHERE table_id = #{tableId}")
    void updateFlag(@Param("tableId")String  tableId, @Param("delFlag")Integer delFlag);
}
