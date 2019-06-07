package com.zyd.report.domain.vo;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

/**
 * 赔偿表 TbIndemnify entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_indemnify", catalog = "tdgh")
public class TbIndemnify implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Fields
	private String id;
	private String tbMonth;// 表日期
	private String idmniCompany;// 涉及赔偿公司
	private String idmniMail;// 涉及赔偿邮件
	private BigDecimal idmniAmount;// 赔偿金额(两位小数)
	private Date idmniDate;// 赔偿日期
	private String idmniReason;// 赔偿原因(中、英、数 200个字)
	private String remark;// 备注(100字)
	private String tbType;
	private String tbName;
	private String deptName;

	// Constructors

	/** default constructor */
	public TbIndemnify() {
	}

	// Property accessors
	@Id
	@GeneratedValue(generator = "hibernate-uuid")
	@GenericGenerator(name = "hibernate-uuid", strategy = "uuid")
	@Column(name = "id")
	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "Tb_Month")
	public String getTbMonth() {
		return this.tbMonth;
	}

	public void setTbMonth(String tbMonth) {
		this.tbMonth = tbMonth;
	}

	@Column(name = "Idmni_Company")
	public String getIdmniCompany() {
		return this.idmniCompany;
	}

	public void setIdmniCompany(String idmniCompany) {
		this.idmniCompany = idmniCompany;
	}

	@Column(name = "Idmni_Mail")
	public String getIdmniMail() {
		return this.idmniMail;
	}

	public void setIdmniMail(String idmniMail) {
		this.idmniMail = idmniMail;
	}

	@Column(name = "Idmni_Amount", precision = 20)
	public BigDecimal getIdmniAmount() {
		return this.idmniAmount;
	}

	public void setIdmniAmount(BigDecimal idmniAmount) {
		this.idmniAmount = idmniAmount;
	}
	@Temporal(TemporalType.DATE)
	@Column(name = "Idmni_Date")
	public Date  getIdmniDate() {
		return this.idmniDate;
	}

	public void setIdmniDate(Date idmniDate) {
		this.idmniDate = idmniDate;
	}

	@Column(name = "Idmni_Reason")
	public String getIdmniReason() {
		return this.idmniReason;
	}

	public void setIdmniReason(String idmniReason) {
		this.idmniReason = idmniReason;
	}

	@Column(name = "Remark")
	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "Tb_Type")
	public String getTbType() {
		return this.tbType;
	}

	public void setTbType(String tbType) {
		this.tbType = tbType;
	}

	@Column(name = "Tb_Name")
	public String getTbName() {
		return this.tbName;
	}

	public void setTbName(String tbName) {
		this.tbName = tbName;
	}
	@Transient
	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

}