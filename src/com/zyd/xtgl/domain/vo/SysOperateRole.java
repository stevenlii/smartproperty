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
@Table(name = "SYS_OPERATE_ROLE")
public class SysOperateRole implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String operateroleid;
	private SysRole sysRole;
	private SysOperate sysOperate;

	public SysOperateRole() {
		// TODO Auto-generated constructor stub
	}

	@Id
	@GeneratedValue(generator = "hibernate-uuid")
	@GenericGenerator(name = "hibernate-uuid", strategy = "uuid")
	@Column(name = "OPERATE_ROLE_ID")
	public String getOperateroleid() {
		return operateroleid;
	}

	public void setOperateroleid(String operateroleid) {
		this.operateroleid = operateroleid;
	}

	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.EAGER)
	@JoinColumn(name = "SYS_OPERATE_ID")
	public SysOperate getSysOperate() {
		return sysOperate;
	}

	public void setSysOperate(SysOperate sysOperate) {
		this.sysOperate = sysOperate;
	}

	public void setSysRole(SysRole sysRole) {
		this.sysRole = sysRole;
	}

	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.EAGER)
	@JoinColumn(name = "sys_role_id")
	public SysRole getSysRole() {
		return sysRole;
	}
}
