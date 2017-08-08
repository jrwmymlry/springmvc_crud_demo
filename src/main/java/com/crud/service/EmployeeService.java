package com.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crud.bean.Employee;
import com.crud.bean.EmployeeExample;
import com.crud.bean.EmployeeExample.Criteria;
import com.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		List<Employee> emps = employeeMapper.selectByExampleWithDept(null);
		return emps;
	}
	
	public void insertEmp(Employee emp)
	{
		employeeMapper.insertSelective(emp);
	}
	
	public boolean checkUser(String empName)
	{
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example );
		return count==0;
	}

	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.updateEmpByPrimaryKeySelective(employee);
	}

	public void delEmpById(Integer empId) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample(); 
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdEqualTo(empId);
		employeeMapper.deleteByExample(example);
	}
}
