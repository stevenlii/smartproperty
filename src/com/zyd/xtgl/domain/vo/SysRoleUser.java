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
@Table(name = "SYS_ROLE_USER")
public class SysRoleUser implements Serializable {
	private static final long serialVersionUID = 1L;
	private String roleUserId;
	private TbAdmUser tbAdmUser;
	private SysRole sysRole;

	public SysRoleUser() {
	}

	@Id
	@GeneratedValue(generator = "hibernate-uuid")
	@GenericGenerator(name = "hibernate-uuid", strategy = "uuid")
	@Column(name = "ROLE_USER_ID")
	public String getRoleUserId() {
		return roleUserId;
	}

	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.EAGER)
	@JoinColumn(name = "ROLE_ID")
	public SysRole getSysRole() {
		return sysRole;
	}

	public void setRoleUserId(String roleUserId) {
		this.roleUserId = roleUserId;
	}

	public void setSysRole(SysRole sysRole) {
		this.sysRole = sysRole;
	}

	public void setTbAdmUser(TbAdmUser tbAdmUser) {
		this.tbAdmUser = tbAdmUser;
	}

	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE }, fetch = FetchType.EAGER)
	@JoinColumn(name = "USER_ID")
	public TbAdmUser getTbAdmUser() {
		return tbAdmUser;
	}

}
