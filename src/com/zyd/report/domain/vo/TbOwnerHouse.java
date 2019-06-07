package com.zyd.report.domain.vo;

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
 * TbOwnerHouse entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_owner_house", catalog = "smartproperty")
public class TbOwnerHouse implements java.io.Serializable {

	// Fields

	/**  描述  */      
	
	private static final long serialVersionUID = 1L;
	private String id;
	private TbHouse tbHouse;
	private TbOwner tbOwner;
	private String remark;
	private String tbType;
	private String tbName;

	// Constructors

	/** default constructor */
	public TbOwnerHouse() {
	}

	/** full constructor */
	public TbOwnerHouse(TbHouse tbHouse, TbOwner tbOwner, String remark,
			String tbType, String tbName) {
		this.tbHouse = tbHouse;
		this.tbOwner = tbOwner;
		this.remark = remark;
		this.tbType = tbType;
		this.tbName = tbName;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "House_id")
	public TbHouse getTbHouse() {
		return this.tbHouse;
	}

	public void setTbHouse(TbHouse tbHouse) {
		this.tbHouse = tbHouse;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Owner_id")
	public TbOwner getTbOwner() {
		return this.tbOwner;
	}

	public void setTbOwner(TbOwner tbOwner) {
		this.tbOwner = tbOwner;
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

}