package com.crud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.crud.bean.Department;
import com.crud.bean.Employee;
import com.crud.bean.Msg;
import com.crud.service.DepartmentService;
import com.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	@Autowired
	DepartmentService departmentService;
	
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model)
	{
		PageHelper.startPage(pn,5);
		List<Employee> emps = employeeService.getAll();
	
		PageInfo page = new PageInfo(emps,5);
		model.addAttribute("pageInfo", page);
		
		return "list";
	}
	
	@ResponseBody
	@RequestMapping("/emps")
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model)
	{
		PageHelper.startPage(pn,5);
		List<Employee> emps = employeeService.getAll();
	
		PageInfo page = new PageInfo(emps,5);
		return Msg.success().add("pageInfo", page);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/saveEmp",method=RequestMethod.POST)
	public Msg saveEmployee(@Valid Employee emp,BindingResult result)
	{
		if(result.hasErrors())
		{
			Map<String,Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for(FieldError error :fieldErrors){
				System.out.println("错误的字段名："+error.getField());
				System.out.println("错误信息："+error.getDefaultMessage());
				map.put(error.getField(),error.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}
		employeeService.insertEmp(emp);
		return Msg.success();
	}
	
	@ResponseBody
	@RequestMapping(value="/checkuser",method=RequestMethod.POST)
	public Msg checkuser(@RequestParam("empName")String empName){
		String regex = "(^[a-zA-Z|0-9_-]{6,16}$)|(^[\u4E00-\u9FA5]{2,4})";
		if(!empName.matches(regex))
		{
			return Msg.fail().add("va_msg","用户名必须是2-4位中文或者6-16位英文和数字的组合");
		}
		
		boolean b = employeeService.checkUser(empName);
		if(b)
		{
			return Msg.success();
		}
		else
		{
			return Msg.fail().add("va_msg", "已有此员工");
		}
	}
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		Employee employee = employeeService.getEmp(id);	
		return Msg.success().add("emp", employee);
	}
	
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.PUT)
	public Msg updateEmp(@PathVariable("id")Integer id,Employee employee){
		employee.setEmpId(id);
		System.out.println(employee.getdId());
		Department department = departmentService.getDeptById(employee.getdId());
		employee.setDepartment(department);
		System.out.println(department);
		employeeService.updateEmp(employee);
		System.out.println(employee);
		return Msg.success().add("employee", employee);
	}
	
	@ResponseBody
	@RequestMapping(value="/emp/{id}",method=RequestMethod.DELETE)
	public Msg deleteEmp(@PathVariable("id") Integer id){
		employeeService.delEmpById(id);
		return Msg.success();
	}
}
