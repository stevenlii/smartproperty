package com.zyd.xtgl.domain.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.validator.constraints.NotEmpty;

/**
 * 
 * @author lgl
 * 
 */
@Entity
@Table(name = "SYS_MODULE")
public class SysModule implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String moduleId;
	@NotEmpty(message = "父类ID不能为空!")
	@NotNull(message = "父类ID不能为空!")
	private String modulePid;
	@NotEmpty(message = "模块名称不能为空!")
	@NotNull(message = "模块名称不能为空!")
	private String moduleName;// 模块名
	@NotEmpty(message = "模块访问路径不能为空!")
	@NotNull(message = "模块访问路径不能为空!")
	private String moduleUrl;// 映射路径
	private Long modulePxh;
	private String modulePName;// 父目录
	private List<SysModule> menus = new ArrayList<SysModule>();

	/** default constructor */
	public SysModule() {
	}

	@Id
	@GeneratedValue(generator = "hibernate-uuid")
	@GenericGenerator(name = "hibernate-uuid", strategy = "uuid")
	@Column(name = "MODULE_ID")
	public String getModuleId() {
		return moduleId;
	}

	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}

	@Column(name = "MODULE_PID")
	public String getModulePid() {
		return modulePid;
	}

	public void setModulePid(String modulePid) {
		this.modulePid = modulePid;
	}

	@Column(name = "MODULE_NAME")
	public String getModuleName() {
		return moduleName;
	}

	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}

	@Column(name = "MODULE_URL")
	public String getModuleUrl() {
		return moduleUrl;
	}

	public void setModuleUrl(String moduleUrl) {
		this.moduleUrl = moduleUrl;
	}

	@Column(name = "MODULE_PXH")
	public Long getModulePxh() {
		return modulePxh;
	}

	public void setModulePxh(Long modulePxh) {
		this.modulePxh = modulePxh;
	}

	public void setMenus(List<SysModule> menus) {
		this.menus = menus;
	}

	@Transient
	public List<SysModule> getMenus() {
		return menus;
	}

	@Transient
	public String getModulePName() {
		return modulePName;
	}

	public void setModulePName(String modulePName) {
		this.modulePName = modulePName;
	}

}
