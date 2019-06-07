package com.zyd.xtgl.domain.vo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * SysDd entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "sys_dd", catalog = "smartproperty")
public class SysDd implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Fields
	private String ddid;
	private String enname;// 操作英文名/代码类型
	private String cnname;// 操作中文名
	private String typeCode;//类型区别代码
	private String type;// 表类型

	// Constructors

	/** default constructor */
	public SysDd() {
	}

	// Property accessors
	@Id
	@GeneratedValue(generator = "hibernate-uuid")
	@GenericGenerator(name = "hibernate-uuid", strategy = "uuid")
	@Column(name = "id")
	public String getDdid() {
		return ddid;
	}

	public void setDdid(String ddid) {
		this.ddid = ddid;
	}

	@Column(name = "EN_Name")
	public String getEnname() {
		return enname;
	}

	public void setEnname(String enname) {
		this.enname = enname;
	}

	@Column(name = "CN_Name")
	public String getCnname() {
		return cnname;
	}

	public void setCnname(String cnname) {
		this.cnname = cnname;
	}

	@Column(name = "Type_Code")
	public String getTypeCode() {
		return typeCode;
	}

	public void setTypeCode(String typeCode) {
		this.typeCode = typeCode;
	}

	@Column(name = "Type")
	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

}