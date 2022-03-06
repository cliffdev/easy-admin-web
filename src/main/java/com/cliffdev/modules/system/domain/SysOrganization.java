package com.cliffdev.modules.system.domain;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author huangzhijun
 */
@TableName("sys_org")
@Data
public class SysOrganization implements Serializable {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private Integer type;
    private String name;
    private String leader;
    private String mobile;
    private String email;
    private String orgNo;
    private String createBy;
    private String updateBy;
    private Date createTime;
    private Date updateTime;
    private String remark;
    private Integer delFlag;
    private Long parentId;

    /**
     * hr系统id
     */
    @TableField(value = "HRORGID")
    private Integer hrorgid;
    /**
     * oa系统id
     */
    @TableField(value = "O_ID")
    private String oId;
    /**
     * OA系统所属部门id或公司id
     */
    @TableField(value = "O_SUP_OID")
    private String oSupOid;
    /**
     * OA系统所属公司id或集团id
     */
    @TableField(value = "O_SUP_CID")
    private String oSupCid;
    /**
     * 最新同步时间
     */
    private Date syncTime;

    private String leaderId;

    private String chargerId;
    @TableField(value = "O_ORG_LEADER")
    private String oOrgLeader;
    @TableField(value = "O_CHARGER")
    private String oCharger;
}
