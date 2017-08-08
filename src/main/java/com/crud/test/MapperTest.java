package com.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.crud.bean.Department;
import com.crud.bean.Employee;
import com.crud.dao.DepartmentMapper;
import com.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="classpath:applicationContext.xml")
public class MapperTest {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession batchSqlSessionTemplate;
	/**
	 * 测department
	 */
	@Test
	public void testCRUD()
	{
		//System.out.println(departmentMapper);
		//departmentMapper.insertSelective(new Department(null,"开发部"));
		//departmentMapper.insertSelective(new Department(null,"测试部"));
		
		//System.out.println(employeeMapper);
		//employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@atguigu.com",1));;
		
	/*	EmployeeMapper mapper=batchSqlSessionTemplate.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++)
		{
			String uid=UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null,uid,"M",uid+"@atguigu.com",1));
		}
		System.out.println("批量操作完成");*/
		
		//employeeMapper.insertSelective(emp);
	}
}
