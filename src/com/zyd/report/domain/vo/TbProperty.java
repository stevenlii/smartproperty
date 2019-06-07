package com.zyd.report.domain.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.GenericGenerator;

/**
 * TbProperty entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tb_property", catalog = "smartproperty")
public class TbProperty implements java.io.Serializable {

	// Fields

	/**  描述  */      
	
	private static final long serialVersionUID = 1L;
	private String id;
	private String houseId;
	private String houseNo;
	private String houseArea;
	private String ownerId;
	private String ownerName;
	private String ownerPhone;
	private String propertyType;
	private String feeIso;
	private String month;
	private String lastMonth;
	private String nowMonth;
	private String feeTotal;
	private String isPay;
	private String remark;
	private String tbType;
	private String tbName;

	// Constructors

	/** default constructor */
	public TbProperty() {
	}

	/** full constructor */
	public TbProperty(String houseId, String houseNo, String houseArea,
			String propertyType, String feeIso, String month, String lastMonth,
			String nowMonth, String feeTotal, String isPay, String remark,
			String tbType, String tbName) {
		this.houseId = houseId;
		this.houseNo = houseNo;
		this.houseArea = houseArea;
		this.propertyType = propertyType;
		this.feeIso = feeIso;
		this.month = month;
		this.lastMonth = lastMonth;
		this.nowMonth = nowMonth;
		this.feeTotal = feeTotal;
		this.isPay = isPay;
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

	@Column(name = "House_Id")
	public String getHouseId() {
		return this.houseId;
	}

	public void setHouseId(String houseId) {
		this.houseId = houseId;
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
	@Column(name = "Owner_Id")
	public String getOwnerId() {
		return ownerId;
	}

	public void setOwnerId(String ownerId) {
		this.ownerId = ownerId;
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
	@Column(name = "Property_Type")
	public String getPropertyType() {
		return this.propertyType;
	}

	public void setPropertyType(String propertyType) {
		this.propertyType = propertyType;
	}

	@Column(name = "Fee_ISO")
	public String getFeeIso() {
		return this.feeIso;
	}

	public void setFeeIso(String feeIso) {
		this.feeIso = feeIso;
	}
	@Column(name = "month")
	public String getMonth() {
		return this.month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	@Column(name = "Last_Month")
	public String getLastMonth() {
		return this.lastMonth;
	}

	public void setLastMonth(String lastMonth) {
		this.lastMonth = lastMonth;
	}

	@Column(name = "Now_Month")
	public String getNowMonth() {
		return this.nowMonth;
	}

	public void setNowMonth(String nowMonth) {
		this.nowMonth = nowMonth;
	}

	@Column(name = "Fee_total")
	public String getFeeTotal() {
		return this.feeTotal;
	}

	public void setFeeTotal(String feeTotal) {
		this.feeTotal = feeTotal;
	}

	@Column(name = "Is_Pay")
	public String getIsPay() {
		return this.isPay;
	}

	public void setIsPay(String isPay) {
		this.isPay = isPay;
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