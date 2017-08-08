package com.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.crud.bean.Department;
import com.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/springmvc.xml"})
public class MvcTest {
	
	@Autowired
	WebApplicationContext context;
	
	MockMvc mockMVC;
	
	@Before
	public void initMockMvc()
	{
		mockMVC = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception
	{
		MvcResult result= mockMVC.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5"))
		.andReturn();
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		System.out.println(pi);
		System.out.println("当前页码："+pi.getPageNum());
		System.out.println("总页码"+pi.getPages());
		System.out.println("总记录数"+pi.getTotal());
		System.out.println("在页面连续显示的页码");
		int[] nums=pi.getNavigatepageNums();
		for (int i:nums) {
			System.out.println(""+i);
		}
		List<Employee> empList = pi.getList();
		for(Employee e:empList)
		{
			System.out.println(e);
		}
	}
	
	@Test
	public void testDeptList() throws Exception
	{
		MvcResult result= mockMVC.perform(MockMvcRequestBuilders.get("/depts"))
			.andReturn();
		MockHttpServletRequest request = result.getRequest();
		List<Department> deptList= (List<Department>) request.getAttribute("deptList");
		System.out.println(deptList);
	}
	
	public void testUpdateEmp() throws Exception
	{
		MvcResult result = mockMVC.perform(MockMvcRequestBuilders.put("/emp/{id}"))
				.andReturn();
		MockHttpServletResponse response = result.getResponse();
		System.out.println(response);
	}
}
