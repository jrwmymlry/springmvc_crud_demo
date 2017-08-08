package com.crud.dao;

import com.crud.bean.Employee;
import com.crud.bean.EmployeeExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
    long countByExample(EmployeeExample example);

    int deleteByExample(EmployeeExample example);

    int insert(Employee record);

    int insertSelective(Employee record);

    List<Employee> selectByExample(EmployeeExample example);
    List<Employee> selectByExampleWithDept(EmployeeExample example);
    
    Employee selectByPrimaryKey(Integer id);
    int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

    int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

	void updateEmpByPrimaryKeySelective(@Param("record") Employee record);
}