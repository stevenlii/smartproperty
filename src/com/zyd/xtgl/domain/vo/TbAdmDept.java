package com.zyd.xtgl.domain.vo;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.validator.constraints.NotEmpty;
/**
 * 
 * @author lgl
 *
 */
@Entity
@Table(name = "TB_ADM_DEPT")
public class TbAdmDept implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String deptid;// 主键
	@NotNull(message = "部门名称不能为空！")
	@NotEmpty(message = "部门名称不能为空！")
	private String deptname;// 公司名称

	private Long serialno;// 排序号

	private String remark;// 备注
	private String companycode;//公司代码
	private String companytypeflag;//公司类型

	public TbAdmDept() {
	}

	@Id
	@GeneratedValue(generator = "hibernate-uuid")
	@GenericGenerator(name = "hibernate-uuid", strategy = "uuid")
	@Column(name = "deptid")
	public String getDeptid() {
		return deptid;
	}

	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}

	@Column(name = "deptname")
	public String getDeptname() {
		return deptname;
	}

	public void setDeptname(String deptname) {
		this.deptname = deptname;
	}

	@Column(name = "serialno")
	public Long getSerialno() {
		return serialno;
	}

	public void setSerialno(Long serialno) {
		this.serialno = serialno;
	}

	@Column(name = "remark")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public void setCompanycode(String companycode) {
		this.companycode = companycode;
	}
	@Column(name = "companycode")
	public String getCompanycode() {
		return companycode;
	}

	public void setCompanytypeflag(String companytypeflag) {
		this.companytypeflag = companytypeflag;
	}
	@Column(name = "companytypeflag")
	public String getCompanytypeflag() {
		return companytypeflag;
	}

}
