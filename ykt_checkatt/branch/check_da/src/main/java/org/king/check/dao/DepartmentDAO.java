package org.king.check.dao;

import org.king.check.common.ec.DBPageLimit;
import org.king.check.domain.Department;
import org.king.framework.dao.MyQuery;

import java.io.Serializable;
import java.util.List;


public interface DepartmentDAO {

    public List find(MyQuery myQuery);

    public List find(String query);

    public List getAll();

    public void save(Department department);

    public void update(Department transientInstance);

    public void delete(Department transientInstance);

    public Department get(Serializable departId);

    public void findDepartmentsByPage(DBPageLimit page, MyQuery myQuery);

    public Department findDepartment(String deptId);

}