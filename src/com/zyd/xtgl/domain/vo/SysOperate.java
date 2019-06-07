package com.zyd.xtgl.domain.vo;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "sys_operate")
public class SysOperate implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String operateid;
	private SysModule sysModule;// 模块
	private SysDd sysssDd;// 数据字典
	private String operateUrl;
	private String purviewen;
	private String purviewcn;

	public void setOperateid(String operateid) {
		this.operateid = operateid;
	}

	@Id
	@GeneratedValue(generator = "hibernate-uuid")
	@GenericGenerator(name = "hibernate-uuid", strategy = "uuid")
	@Column(name = "operate_id")
	public String getOperateid() {
		return operateid;
	}

	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.EAGER)
	@JoinColumn(name = "MODULE_ID")
	public SysModule getSysModule() {
		return sysModule;
	}

	public void setSysModule(SysModule sysModule) {
		this.sysModule = sysModule;
	}

	@Column(name = "purview_en")
	public String getPurviewen() {
		return purviewen;
	}

	public void setPurviewen(String purviewen) {
		this.purviewen = purviewen;
	}

	@Column(name = "purview_cn")
	public String getPurviewcn() {
		return purviewcn;
	}

	public void setPurviewcn(String purviewcn) {
		this.purviewcn = purviewcn;
	}

	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.EAGER)
	@JoinColumn(name = "ddid")
	public SysDd getSysssDd() {
		return sysssDd;
	}

	public void setSysssDd(SysDd sysssDd) {
		this.sysssDd = sysssDd;
	}
	@Column(name="operate_url")
	public String getOperateUrl() {
		return operateUrl;
	}

	public void setOperateUrl(String operateUrl) {
		this.operateUrl = operateUrl;
	}
}
