<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- 不以/开始的相对路径，找资源，是以当前资源的路径为基准的，经常容易出问题 
以/开始的相对路径，找资源,是以服务器的路径为标准：http://localhost:/3306
可以以这样的方式引入：src="/crud/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"
-->

<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>

<body>
<!-- Modal -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" >员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-10">
							<p class="form-control-static" name="empName" id="empName_update_static"></p>
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control" id="email_update_input"
									placeholder="email@atguigu.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="gender_add_input" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> 
									<input type="radio" name="gender" id="gender_update_input" value="M" checked="checked"> 男
								</label> 
								<label class="radio-inline"> 
									<input type="radio" name="gender" id="gender_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_update_select">
									
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>
<!-- Modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加一个员工</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-2 control-label">员工姓名</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control" id="empName_add_input"
									placeholder="empName">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control" id="email_add_input"
									placeholder="email@atguigu.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="gender_add_input" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> 
									<input type="radio" name="gender" id="gender_add_input" value="M" checked="checked"> 男
								</label> 
								<label class="radio-inline"> 
									<input type="radio" name="gender" id="gender_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId" id="dept_select">
									
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 搭建显示页面 -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger" id="emp_del_modal_btn">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>


					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6" id="build_page_nav"></div>
		</div>
	</div>

	<script type="text/javascript">
	
		var totalPages;
		
		$(function() {
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result);
				},
				error: function(result) {
					alert(result);
				}
			});
		}

		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var gender = item.gender == 'M' ? "男" : "女";
				var empGenderTd = $("<td></td>").append(gender);
				var emailTd = $("<td></td>").append(item.email);
				
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);

				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm edit_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil")).append("编辑");
				editBtn.attr("edit_id",item.empId);
				editBtn.attr("pageNum",result.extend.pageInfo.pageNum);
				
				var deleteBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash")).append(
						"删除");
				
				deleteBtn.attr("del_id",item.empId);
				deleteBtn.attr("pageNum",result.extend.pageInfo.pageNum);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(
						deleteBtn);
				$("<tr></tr>").append(empIdTd).append(empNameTd).append(
						empGenderTd).append(emailTd).append(deptNameTd).append(
						btnTd).appendTo("#emps_table tbody");
			});
		}

		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前第" + result.extend.pageInfo.pageNum + "页，总"
							+ result.extend.pageInfo.pages + "页，总共"
							+ result.extend.pageInfo.total + "条记录");
			totalPages = result.extend.pageInfo.pages;
		}

		function build_page_nav(result) {
			$("#build_page_nav").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			firstPageLi.click(function() {
				to_page(1);
			});
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			prePageLi.click(function() {
				to_page(result.extend.pageInfo.pageNum-1);
			});
			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			lastPageLi.click(function() {
				to_page(result.extend.pageInfo.pages);
			});
			nextPageLi.click(function() {
				to_page(result.extend.pageInfo.nextPage);
			});
			if (result.extend.pageInfo.hasNextPage == false) {
				lastPageLi.addClass("disabled");
				nextPageLi.addClass("disabled");
			}

			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			ul.append(nextPageLi).append(lastPageLi);
			var nav = $("<nav></nav>").append(ul);
			nav.appendTo("#build_page_nav");
		}
		
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		$("#emp_add_modal_btn").click(function(){

			reset_form("#empAddModal form");
			
			getDepts("#dept_select");
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		function getDepts(ele)
		{
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					$.each(result.extend.deptList,function(){
						var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		function validate_add_form()
		{
			var empName=$("#empName_add_input");
			var regName=/(^[a-zA-Z|0-9_-]{6,16}$)|(^[\u4E00-\u9FA5]{2,4})/;
			if(!regName.test(empName))
			{
				show_validate_msg("#empName_add_input","error","用户名可以是2-4位中文或者6-16位英文和数字的组合");
			
			}
			else{
				show_validate_msg("#empName_add_input","success","用户名格式正确");
			}
			var email = $("#email_add_input").val();
			var regEmail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/
			if(!regEmail.test(email))
			{
				show_validate_msg("#email_add_input","error","邮箱格式不正确");	
			}
			else{
				show_validate_msg("#email_add_input","success","邮箱格式正确");		
			}
			return true;
		}
		
		function show_validate_msg(ele,status,msg){
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success"==status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}
			else if("error"==status)
			{
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		$("#emp_save_btn").click(function() {
			/*if (!validate_add_form()) {
				return false;
			}*/
			if($(this).attr("ajax_va")=="error"){
				return false;
			}
			$.ajax({

				url : "${APP_PATH}/saveEmp",
				type : "POST",
				data : $("#empAddModal form").serialize(),
				success : function(result) {
					if(result.code==200)
					{
						$("#empAddModal").modal('hide');
						alert(totalPages);
						to_page(9999);		
					}
					else
					{
						if(undefined!=result.extend.errorFields.email)
						{
							show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
						}
						if(undefined!=result.extend.errorFields.empName)
						{
							show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
							
						}
					}
				}
			});
		})
		
		$("#empName_add_input").change(function()
		{
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if(result.code==200){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax_va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax_va","error");
						alert("用户名已存在！");
					}
				}
			});
		});
		
	
		$(document).on("click", ".edit_btn", function() {

			getDepts("#empUpdateModal select");
			getEmp($(this).attr("edit_id"));
			
			$("#emp_update_btn").attr("edit_id",$(this).attr("edit_id"));
			$("#emp_update_btn").attr("pageNum",$(this).attr("pageNum"));
			
			$("#empUpdateModal").modal({
				backdrop : "static"
			});
		});
		
		$(document).on("click", ".delete_btn", function(){
			var empName=$(this).parents("tr").find("td:eq(1)").text();
			if(confirm("确认删除【"+empName+"】吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("del_id"),
					type:"DELETE",
					async:false,
					success:function(result){
						
					}
				});
				to_page($(this).attr("pageNum"));
			}
		});
		
		function getEmp(id){
			
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[type='radio']").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
				
			});
		}
		
		$("#emp_update_btn").click(function(){
			var email = $("#email_update_input").val();
			var regEmail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((\.[a-zA-Z0-9_-]{2,3}){1,2})$/
			if(!regEmail.test(email))
			{
				show_validate_msg("#email_add_input","error","邮箱格式不正确");	
				return false;
			}
			else{
				show_validate_msg("#email_add_input","success","邮箱格式正确");		
			}
			
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
			//	type:"POST",
			//	data:$("#empUpdateModal form").serialize()+"&_method=PUT",
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					$("#empUpdateModal").modal('hide');
					to_page($("#emp_update_btn").attr("pageNum"));
				}
			});
		});
		
		
	</script>

</body>
</html>