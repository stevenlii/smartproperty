package com.zyd.report.domain.vo;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

/**
 * TbHouse entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_house", catalog = "smartproperty")
public class TbHouse implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Fields
	private String id;
	private String houseNo;
	private String houseArea;
	private String remark;
	private String tbType;
	private String tbName;
	private Set<TbOwnerHouse> tbOwnerHouses = new HashSet<TbOwnerHouse>(0);

	// Constructors

	/** default constructor */
	public TbHouse() {
	}

	/** full constructor */
	public TbHouse(String houseNo, String houseArea, String remark,
			String tbType, String tbName, Set<TbOwnerHouse> tbOwnerHouses) {
		this.houseNo = houseNo;
		this.houseArea = houseArea;
		this.remark = remark;
		this.tbType = tbType;
		this.tbName = tbName;
		this.tbOwnerHouses = tbOwnerHouses;
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

	@Column(name = "House_no")
	public String getHouseNo() {
		return this.houseNo;
	}

	public void setHouseNo(String houseNo) {
		this.houseNo = houseNo;
	}

	@Column(name = "House_area")
	public String getHouseArea() {
		return this.houseArea;
	}

	public void setHouseArea(String houseArea) {
		this.houseArea = houseArea;
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

//	千万不能加，否则页面读取不了值
//@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbHouse")
	@Transient
	public Set<TbOwnerHouse> getTbOwnerHouses() {
		return this.tbOwnerHouses;
	}

	public void setTbOwnerHouses(Set<TbOwnerHouse> tbOwnerHouses) {
		this.tbOwnerHouses = tbOwnerHouses;
	}

}