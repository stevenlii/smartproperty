package com.zyd.xtgl.domain.vo;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
@Table(name = "TB_ADM_USER")
public class TbAdmUser implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String userid;// 主键
	@NotEmpty(message = "用户名不能为空!")
	@NotNull(message = "用户名不能为空!")
	private String username;// 登录用户名
	@NotEmpty(message = "密码不能为空!")
	@NotNull(message = "密码不能为空!")
	private String password;// 密码

	private String ryname;// 姓名

	private String remark;// 备注

	private Long serialno;// 排序号
	
	private String accessCompany;//入网公司

	private TbAdmDept tbadmDept;

	public TbAdmUser() {
	}

	@Id
	@GeneratedValue(generator = "hibernate-uuid")
	@GenericGenerator(name = "hibernate-uuid", strategy = "uuid")
	@Column(name = "USERID")
	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	@Column(name = "USERNAME")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "PASSWORD")
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "RYNAME")
	public String getRyname() {
		return ryname;
	}

	public void setRyname(String ryname) {
		this.ryname = ryname;
	}

	@Column(name = "REMARK")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "SERIALNO")
	public Long getSerialno() {
		return serialno;
	}

	public void setSerialno(Long serialno) {
		this.serialno = serialno;
	}

	public void setTbadmDept(TbAdmDept tbadmDept) {
		this.tbadmDept = tbadmDept;
	}

	@ManyToOne(cascade = { CascadeType.PERSIST, CascadeType.MERGE })
	@JoinColumn(name = "DEPTID")
	public TbAdmDept getTbadmDept() {
		return tbadmDept;
	}
    @Column(name = "ACCESSCOMPANY")
	public String getAccessCompany() {
		return accessCompany;
	}

	public void setAccessCompany(String accessCompany) {
		this.accessCompany = accessCompany;
	}
	

}
