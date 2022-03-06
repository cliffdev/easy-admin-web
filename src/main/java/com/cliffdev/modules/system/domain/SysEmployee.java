package com.cliffdev.modules.system.domain;

import com.baomidou.mybatisplus.annotation.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author LaiZhiShen
 * @date 2021-03-02
 * @description 人员
 */
@TableName("sys_employee")
@Data
public class SysEmployee implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 记录id，可换成全局生成id
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Long id;
    /**
     * 用户名
     */
    private String username;
    /**
     * 密码
     */
    private String password;
    /**
     * 用户姓名
     */
    private String nickname;
    /**
     * 邮箱
     */
    private String email;
    /**
     * 联系电话
     */
    private String mobile;
    /**
     * 身份证
     */
    private String idCard;
    /**
     * 人员级别
     */
    private String level;
    /**
     * 职位名称
     */
    private String positionName;
    /**
     * 人员工号
     */
    private String employeeNo;
    /**
     * 部门id
     */
    private Integer deptId;
    /**
     * 楼栋编号
     */
    private String buildingNo;
    /**
     * 宿舍编号
     */
    private String roomNo;
    /**
     * 床位编号
     */
    private String bedNo;
    /**
     * 宿舍预约
     */
    private Integer roomFlag;
    /**
     * 公车预约
     */
    private Integer vehicalFlag;
    /**
     * 在职情况，0在 1否
     */
    private Integer status;
    /**
     * 创建者
     */
    private String createBy;
    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.DEFAULT)
    private Date createTime;
    /**
     * 更新者
     */
    private String updateBy;
    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.DEFAULT)
    private Date updateTime;
    /**
     * 备注
     */
    private String remark;
    /**
     * 0代表存在 1代表删除
     */
    @TableField(fill = FieldFill.DEFAULT)
    private Integer delFlag;
    /**
     * 0 否 1宿舍 10 班车 11 宿舍+ 班车 数据字典 employee_backlist_type
     */
    private Integer blacklist;
    /**
     * 公司id
     */
    private Integer orgId;
    /**
     * 0 女 1男 2 未知
     */
    private Integer gender;
    /**
     * ehr的id用于同步
     */
    @TableField(value = "EID")
    private Integer eid;
    /**
     * 钉钉用户userid
     */
    private String dingtalkUserid;
    /**
     * 系统用户id
     */
    private Long userId;

    /**
     * oa同步eloginid
     */
    @TableField(value = "E_LOGINID")
    private Integer eLoginid;
    /**
     * 分部id
     */
    @TableField(value = "E_SUBCOM")
    private Integer eSubcom;
    /**
     * 部门id
     */
    @TableField(value = "E_ORGID")
    private Integer eOrgid;
    /**
     * 岗位id
     */
    @TableField(value = "E_PID")
    private Integer ePid;
    /**
     * 是否主账号 1是 0 否
     */
    @TableField(value = "E_ACCOUNTTYPE")
    private Integer eAccounttype;
    /**
     * 父账号类型
     */
    @TableField(value = "E_BELONGTO")
    private Integer eBelongto;
    /**
     * 嘉扬HR的岗位ID
     */
    @TableField(value = "JOBID")
    private Integer jobid;
    /**
     * 嘉扬HR的部门ID
     */
    @TableField(value = "DEPID")
    private Integer depid;
    /**
     * 人员最新同步时间
     */
    private Date employeeSyncTime;
    /**
     * 岗位最新同步时间
     */
    private Date positionSyncTime;
    /**
     * 职级名称
     */
    private String levelName;

    /**
     * 入住时间
     */
    private Date checkInTime;
}
