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
/**
 * 
 * @author lgl
 *
 */
@Entity
@Table(name = "SYS_MODULE_ROLE")
public class SysModuleRole implements Serializable {

	private static final long serialVersionUID = 1L;
	private String moduleRoleId;
	private SysModule sysModule;
	private SysRole sysRole;

	public SysModuleRole() {
	}

	@Id
	@GeneratedValue(generator = "hibernate-uuid")
	@GenericGenerator(name = "hibernate-uuid", strategy = "uuid")
	@Column(name = "MODULE_ROLE_ID")
	public String getModuleRoleId() {
		return moduleRoleId;
	}

	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.EAGER)
	@JoinColumn(name = "MODULE_ID")
	public SysModule getSysModule() {
		return sysModule;
	}

	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.EAGER)
	@JoinColumn(name = "ROLE_ID")
	public SysRole getSysRole() {
		return sysRole;
	}

	public void setModuleRoleId(String moduleRoleId) {
		this.moduleRoleId = moduleRoleId;
	}

	public void setSysModule(SysModule sysModule) {
		this.sysModule = sysModule;
	}

	public void setSysRole(SysRole sysRole) {
		this.sysRole = sysRole;
	}
}
