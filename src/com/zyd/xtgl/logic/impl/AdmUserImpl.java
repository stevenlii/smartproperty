package com.zyd.xtgl.logic.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.zyd.xtgl.dao.IAdmUserDAO;
import com.zyd.xtgl.dao.IModuleRoleDAO;
import com.zyd.xtgl.dao.IRoleUserDAO;
import com.zyd.xtgl.domain.vo.SysModule;
import com.zyd.xtgl.domain.vo.TbAdmUser;
import com.zyd.xtgl.logic.IAdmUserFacade;

@Service("admUserImpl")
public class AdmUserImpl implements IAdmUserFacade {
	private IAdmUserDAO admUserDAOImpl;
	private IRoleUserDAO roleUserDAOImpl;
	private IModuleRoleDAO moduleRoleDAOImpl;

	@Resource(name = "roleUserDAOImpl")
	public void setRoleUserDAOImpl(IRoleUserDAO roleUserDAOImpl) {
		this.roleUserDAOImpl = roleUserDAOImpl;
	}

	@Resource(name = "admUserDAOImpl")
	public void setAdmUserDAOImpl(IAdmUserDAO admUserDAOImpl) {
		this.admUserDAOImpl = admUserDAOImpl;
	}

	@Resource(name = "moduleRoleDAOImpl")
	public void setModuleRoleDAOImpl(IModuleRoleDAO moduleRoleDAOImpl) {
		this.moduleRoleDAOImpl = moduleRoleDAOImpl;
	}

	@Override
	public List<TbAdmUser> getUserList() {
		return admUserDAOImpl.getUserList();
	}

	public boolean checkUserName(String userName) {
		List<TbAdmUser> list = admUserDAOImpl.getListByUsername(userName);
		if (list.size() > 0) {
			return true;
		}
		return false;
	}

	@Override
	public void addUser(TbAdmUser userBean) {
		admUserDAOImpl.addUser(userBean);
	}

	@Override
	public void updateUser(TbAdmUser userBean) {
		admUserDAOImpl.updateUser(userBean);
	}

	@Override
	public void delUser(String userid) {
		admUserDAOImpl.delUser(userid);
	}

	@Override
	public boolean checkUser(String userName, String pwd) {
		boolean flag = false;
		List<TbAdmUser> admUserlist = admUserDAOImpl
				.getListByUsername(userName);
		if (admUserlist.size() > 0) {
			String password = admUserlist.get(0).getPassword().trim();
			if (password.equals(pwd.trim())) {
				flag = true;
			}
		}
		return flag;
	}

	@Override
	public List<SysModule> getMainMenu(String userId) {
		if ("admin".equals(userId)) {
			return getSuperManagerMenu();
		} else {
			return getUserMenu(userId);
		}
	}

	public List<SysModule> getSuperManagerMenu() {
		List<SysModule> list = moduleRoleDAOImpl.getNodeList("-1");
		List<SysModule> returnlist = new ArrayList<SysModule>();
		for (SysModule module : list) {
			List<SysModule> listchild = moduleRoleDAOImpl.getNodeList(module
					.getModuleId());
			List<SysModule> chidprivilege = new ArrayList<SysModule>();
			for (SysModule modulechild : listchild) {
				chidprivilege.add(modulechild);
			}
			module.setMenus(chidprivilege);
			returnlist.add(module);
		}
		return returnlist;
	}

	public List<SysModule> getUserMenu(String userId) {
		List<SysModule> list = moduleRoleDAOImpl.getNodeList("-1");
		List<SysModule> returnlist = new ArrayList<SysModule>();
		for (SysModule module : list) {
			if (moduleRoleDAOImpl.hasPrivilege(module.getModuleId(), userId)) {
				List<SysModule> listchild = moduleRoleDAOImpl
						.getNodeList(module.getModuleId());
				List<SysModule> chidprivilege = new ArrayList<SysModule>();
				for (SysModule modulechild : listchild) {
					if (moduleRoleDAOImpl.hasPrivilege(
							modulechild.getModuleId(), userId)) {
						chidprivilege.add(modulechild);
					}
				}
				module.setMenus(chidprivilege);
				returnlist.add(module);
			}
		}
		return returnlist;
	}

	public List<SysModule> getMainMenuChildren(String userId) {
		List<SysModule> list = moduleRoleDAOImpl.getNodeList("-1");//父ID
		List<SysModule> listchild = null;
		for (SysModule module : list) {
			if (moduleRoleDAOImpl.hasPrivilege(module.getModuleId(), userId)) {
				listchild = moduleRoleDAOImpl.getNodeList(module.getModuleId());
				List<SysModule> chidprivilege = new ArrayList<SysModule>();
				for (SysModule modulechild : listchild) {
					if (moduleRoleDAOImpl.hasPrivilege(
							modulechild.getModuleId(), userId)) {
						chidprivilege.add(modulechild);
					}
				}
				module.setMenus(chidprivilege);
			}
		}
		return listchild;
	}

	@Override
	public void updateUserPass(String userId, String newUserPass11) {
		admUserDAOImpl.changeUserPass(userId, newUserPass11);
	}

	@Override
	public List<TbAdmUser> getUserListOfDept(String deptid) {
		return admUserDAOImpl.getUserListOfDept(deptid);
	}

	@Override
	public TbAdmUser getCuruserinfo(String userName) {
		List<TbAdmUser> list = admUserDAOImpl.getListByUsername(userName);
		if (list.size() > 0) {
			return list.get(0);
		}
		return new TbAdmUser();
	}

	@Override
	public boolean getIsManagerType(String userid, String roleId) {
		boolean isManager = false;
		if (userid != null && !"".equals(userid)) {
			String roleIds = roleUserDAOImpl.getRoleIdsByUserId(userid);
			if (roleIds != null && !"".equals(roleIds)) {
				String[] roles = roleIds.split(",");
				for (int i = 0; i < roles.length; i++) {
					if (roleId.equals(roles[i])) {
						isManager = true;
						break;
					}
				}
			}
		}
		return isManager;
	}

	@Override
	public TbAdmUser getByUserid(String userid) {
		return admUserDAOImpl.getByUserid(userid);
	}

	@Override
	public List<TbAdmUser> getUserPageList(int rowStartIdx, int rowCount) {
		return admUserDAOImpl.getUserPageList(rowStartIdx, rowCount);
	}

	@Override
	public long getUserPageCount() {
		return admUserDAOImpl.getUserPageCount();
	}

}
