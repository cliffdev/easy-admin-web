package com.cliffdev.modules.query.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cliffdev.modules.query.domain.EasyQueryColumn;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

/**
 * @author huangzhijun
 */
@Mapper
public interface EasyQueryColumnMapper extends BaseMapper<EasyQueryColumn> {

    @Update("UPDATE sys_query_column SET del_flag = #{delFlag} WHERE table_id = #{tableId}")
    void updateFlag(@Param("tableId")String  tableId, @Param("delFlag")Integer delFlag);
}
