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
 * TbOwner entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_owner", catalog = "smartproperty")
public class TbOwner implements java.io.Serializable {

	/**  描述  */      
	
	private static final long serialVersionUID = 1L;
	// Fields

	private String id;
	private String ownerName;
	private String ownerPhone;
	private String houseId;
	private String remark;
	private String tbType;
	private String tbName;
	private Set<TbOwnerHouse> tbOwnerHouses = new HashSet<TbOwnerHouse>(0);
	private Set<TbHouse> tbHouses = new HashSet<TbHouse>(0);

	// Constructors

	/** default constructor */
	public TbOwner() {
	}

	/** full constructor */
	public TbOwner(String ownerName, String ownerPhone, String remark,
			String tbType, String tbName, Set<TbOwnerHouse> tbOwnerHouses) {
		this.ownerName = ownerName;
		this.ownerPhone = ownerPhone;
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

	@Column(name = "Owner_Name")
	public String getOwnerName() {
		return this.ownerName;
	}

	public void setOwnerName(String ownerName) {
		this.ownerName = ownerName;
	}

	@Column(name = "Owner_Phone")
	public String getOwnerPhone() {
		return this.ownerPhone;
	}

	public void setOwnerPhone(String ownerPhone) {
		this.ownerPhone = ownerPhone;
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

	//@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbOwner")
	@Transient
	public Set<TbOwnerHouse> getTbOwnerHouses() {
		return this.tbOwnerHouses;
	}

	public void setTbOwnerHouses(Set<TbOwnerHouse> tbOwnerHouses) {
		this.tbOwnerHouses = tbOwnerHouses;
	}
	@Column(name = "House_id")
	public String getHouseId() {
		return this.houseId;
	}

	public void setHouseId(String houseId) {
		this.houseId = houseId;
	}
	@Transient
	public Set<TbHouse> getTbHouses() {
		return tbHouses;
	}

	public void setTbHouses(Set<TbHouse> tbHouses) {
		this.tbHouses = tbHouses;
	}

}