package com.zyd.xtgl.dao.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.zyd.common.GenericHibernateDao;
import com.zyd.xtgl.dao.IAdmUserDAO;
import com.zyd.xtgl.domain.vo.TbAdmUser;

@Repository("admUserDAOImpl")
public class AdmUserDAOImpl extends GenericHibernateDao<TbAdmUser> implements IAdmUserDAO {
	@Override
	public List<TbAdmUser> getUserList() {
		String sql = "from TbAdmUser a order by a.serialno";
		return this.find(sql);
	}

	@Override
	public List<TbAdmUser> getListByUsername(String username) {
		List<TbAdmUser> list = (List<TbAdmUser>) this.find(
				" from TbAdmUser t where t.username=?", username.trim());
		return list;
	}

	@Override
	public void addUser(TbAdmUser UserBean) {
		this.create(UserBean);
	}

	@Override
	public void delUser(String userid) {
		this.bulkUpdate("delete from TbAdmUser t where t.userid =?", new Object[]{userid});
	}

	@Override
	public void updateUser(TbAdmUser UserBean) {
		this.update(UserBean);
	}


	@Override
	public void changeUserPass(String userId, String newUserPass11) {
		TbAdmUser tbadmuser = (TbAdmUser) this
				.findById(new TbAdmUser(), userId);
		if (tbadmuser != null) {
			tbadmuser.setPassword(newUserPass11);
			this.update(tbadmuser);
		}
	}

	@Override
	public List<TbAdmUser> getUserListOfDept(String deptid) {
		List<TbAdmUser> list = this
				.find(" from TbAdmUser t where t.tbadmDept.deptid=? order by serialno",
						deptid);
		return list;
	}


	@Override
	public TbAdmUser getByUserid(String userid) {
		return (TbAdmUser) this.findById(new TbAdmUser(), userid);
	}

	@Override
	public List<TbAdmUser> getUserPageList(int rowStartIdx, int rowCount) {
		return this.findPaged("from TbAdmUser u order by u.serialno",
				rowStartIdx, rowCount);
	}

	@Override
	public long getUserPageCount() {
		return this
				.findPagedConut("select count(*) from TbAdmUser u order by u.serialno");
	}

}
