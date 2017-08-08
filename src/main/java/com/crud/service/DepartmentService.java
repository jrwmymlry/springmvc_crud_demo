package com.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.crud.bean.Department;
import com.crud.dao.DepartmentMapper;

@Service
public class DepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	public List<Department> GetDeptList()
	{
		return departmentMapper.selectByExample(null);
	}

	public Department getDeptById(Integer deptId) {
		// TODO Auto-generated method stub
		
		return departmentMapper.selectDeptById(deptId);
		
	}
}
