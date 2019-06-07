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
@Table(name = "SYS_ROLE")
public class SysRole implements Serializable {
	private static final long serialVersionUID = 1L;
	private String roleId;
	private String rolePid;
	@NotEmpty
	@NotNull
	private String roleName;
	private String remark;

	public SysRole() {
	}

	@Column(name = "remark")
	public String getRemark() {
		return remark;
	}

	@Id
	@GeneratedValue(generator = "hibernate-uuid")
	@GenericGenerator(name = "hibernate-uuid", strategy = "uuid")
	@Column(name = "ROLE_ID")
	public String getRoleId() {
		return roleId;
	}

	@Column(name = "ROLE_NAME")
	public String getRoleName() {
		return roleName;
	}

	@Column(name = "ROLE_PID")
	public String getRolePid() {
		return rolePid;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public void setRolePid(String rolePid) {
		this.rolePid = rolePid;
	}

}