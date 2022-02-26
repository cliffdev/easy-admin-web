package com.cliffdev.modules.query.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.cliffdev.modules.query.domain.EasyQueryTable;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

/**
 * @author huangzhijun
 */
@Mapper
public interface EasyQueryTableMapper extends BaseMapper<EasyQueryTable> {

    @Update("UPDATE sys_query_table SET del_flag = #{delFlag} WHERE table_id = #{tableId}")
    void updateFlag(@Param("tableId")String  tableId, @Param("delFlag")Integer delFlag);

}
