<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ page errorPage="/power_error.jsp" %>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script src="static/vue/vue.js"></script>
		<script src="static/vue/vue-router.js"></script>
		<link rel="stylesheet" type="text/css" href="static/bootstrap/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="static/element-ui-2.14.0/index.css" />
		<script src="static/element-ui-2.14.0/index.js"></script>
		<script src="static/database.js" type="text/javascript"></script>
		<script src="static/jquery-3.5.1.min.js"></script>
		<title>欢迎来到管理系统</title>
	</head>
	<body>
		<%@ page import="bean.User" %>
		<%User user = new User(); user = (User)request.getSession().getAttribute("user");%>
		<%if((!user.getRole().equals("经理"))||user.getRole()==null){ 
		response.sendRedirect("/z-index/power_error.jsp");%>
		<%} %>

		<div id="app">
			<el-dialog title="添加员工" :visible.sync="dialogFormVisible">
				<el-form ref="form" :model="form" :rules="rules">
					<el-form-item label="员工姓名" prop="name" :label-width="formLabelWidth">
						<el-input v-model="form.name" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="员工账号" prop="account" :label-width="formLabelWidth">
						<el-input v-model="form.account" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="员工身份证号" prop="idcard" :label-width="formLabelWidth">
						<el-input v-model="form.idcard" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="员工职务" prop="role" :label-width="formLabelWidth">
						<el-select v-model="form.role" placeholder="请选择员工职务">
							<el-option label="管理员" value="管理员"></el-option>
							<el-option label="普通业务员" value="普通业务员"></el-option>
							<el-option label="经理" value="经理"></el-option>
						</el-select>
					</el-form-item>
				</el-form>
				<div slot="footer" class="dialog-footer">
					<el-button @click="cancel()">取 消</el-button>
					<el-button type="primary" @click="submitForm('form')">确 定</el-button>
				</div>
			</el-dialog>
			
			
			<el-dialog title="添加员工" :visible.sync="EditFormVisible">
				<el-form ref="editform" :model="editform" :rules="rules">
					<el-form-item label="员工编号" prop="id" :label-width="formLabelWidth">
						<el-input :disabled="true" v-model="editform.id" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="员工姓名" prop="name" :label-width="formLabelWidth">
						<el-input v-model="editform.name" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="员工账号" prop="account" :label-width="formLabelWidth">
						<el-input v-model="editform.account" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="员工密码" prop="password" :label-width="formLabelWidth">
						<el-input v-model="editform.password" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="员工身份证号" prop="idcard" :label-width="formLabelWidth">
						<el-input v-model="editform.idcard" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="员工职务" prop="role" :label-width="formLabelWidth">
						<el-select v-model="editform.role" placeholder="请选择员工职务">
							<el-option label="管理员" value="管理员"></el-option>
							<el-option label="普通业务员" value="普通业务员"></el-option>
							<el-option label="经理" value="经理"></el-option>
						</el-select>
					</el-form-item>
				</el-form>
				<div slot="footer" class="dialog-footer">
					<el-button @click="editcancel()">取 消</el-button>
					<el-button type="primary" @click="submitUpdate('editform')">确 定</el-button>
				</div>
			</el-dialog>
			
			
			
			<div class="container">
				<div class="row">
					<div class="col-md-3">
						<h1 class="mt-3">欢迎你
							<%=user.getName() %>
						</h1>
					</div>
					<div class="col-md-7"></div>
					<div class="col-md-2">
						<el-button type="primary" @click="addUser()" class="mt-5" round>添加员工</el-button>
					</div>
				</div>
				<el-table :data="tableData.filter(data => !search || data.name.toLowerCase().includes(search.toLowerCase()))" style="width: 100%">
					<el-table-column label="员工编号" prop="id">
					</el-table-column>
					<el-table-column label="姓名" prop="name">
					</el-table-column>
					<el-table-column label="账号" prop="account">
					</el-table-column>
					<el-table-column label="密码" prop="password">
					</el-table-column>
					<el-table-column label="身份证号" prop="idcard">
					</el-table-column>
					<el-table-column label="职务" prop="role">
					</el-table-column>
					<el-table-column align="right">
						<template slot="header" slot-scope="scope">
							<el-input v-model="search" size="mini" placeholder="输入关键字搜索" />
						</template>
						<template slot-scope="scope">
							<el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
							<el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
						</template>
					</el-table-column>
				</el-table>
			</div>
		</div>
	</body>
	<script>
		new Vue({
			el: '#app',
			data() {
				return {
					tableData: [],
					search: '',
					dialogFormVisible: false,
					EditFormVisible:false,
					form: {
						name: '',
						role: '',
						idcard: '',
						account: ''
					},
					editform:{
						id:'',
						name: '',
						role: '',
						idcard: '',
						account: '',
						password:''
					},
					formLabelWidth: '120px',
					rules: {
						name: [{
							required: true,
							message: '姓名不可为空',
							trigger: 'blur'
						}],
						account: [{
							required: true,
							message: '账号不可为空',
							trigger: 'blur'
						}],
						password: [{
							required: true,
							message: '密码不可为空',
							trigger: 'blur'
						}],
						idcard: [{
								required: true,
								message: '身份证号码不可为空',
								trigger: 'blur'
							},
							{
								min: 18,
								max: 18,
								message: '身份证号码必须为18位',
								trigger: 'blur'
							}
						],
						role: [{
							required: true,
							message: '请选择角色',
							trigger: 'blur'
						}]
					},
				}
			},
			methods: {
				handleEdit(index, row) {
					console.log(index, row);
					this.editform = row;
					this.EditFormVisible=true;
				},
				editcancel(){
					this.EditFormVisible=false;
				},
				//删除用户
				handleDelete(index, row) {
					console.log(row.id);

					this.$confirm('此操作将永久删除用户' + row.name + '的信息是否继续?', '提示', {
						confirmButtonText: '确定',
						cancelButtonText: '取消',
						type: 'warning'
					}).then(() => {
						var self = this;
						$.ajax({
							type: 'POST',
							async: false,
							url: serve_url + "deleteuser",
							data: JSON.stringify({
								"id": row.id
							}),
							success: function(res) {
								console.log(res)
								if (res == "true") {
									self.getUsers();
									self.$message({
										message: '删除成功',
										type: 'success'
									});
								} else {
									self.$message.error('删除失败');
								}
								self.dialogFormVisible = false;
							}
						})
					}).catch(() => {
						this.$message({
							type: 'info',
							message: '已取消删除'
						});
					});
				},
				receive_users(msg) {
					this.tableData = msg;
					console.log(this.tableData);
				},
				//打开增加用户窗口
				addUser() {
					this.dialogFormVisible = true;
				},
				//获取所有用户
				getUsers() {
					var self = this;
					$.ajax({
						type: 'get',
						async: false,
						dataType: 'JSON',
						url: serve_url + "listall_user",
						success: function(res) {
							self.receive_users(res);
						}
					})
				},
				//提交新用户信息
				submitForm(formName) {
					this.$refs[formName].validate((valid) => {
						if (valid) {
							var self = this;
							$.ajax({
								type: 'POST',
								async: false,
								url: serve_url + "adduser",
								data: JSON.stringify(this.form),
								success: function(res) {
									console.log(res)
									self.getUsers();
									if (res == "true") {
										self.$message({
											message: '添加成功',
											type: 'success'
										});
									} else {
										self.$message.error('添加失败');
									}

									self.resetForm('form');
									self.dialogFormVisible = false;
								}
							})
						} else {
							console.log('error submit!!');
							return false;
						}
					});
				},
				//关闭弹出窗口
				cancel() {
					this.dialogFormVisible = false;
					this.resetForm('form');
				},
				resetForm(formName) {
					this.$refs[formName].resetFields();
				},
				//提交用户修改信息
				submitUpdate(formName){
					this.$refs[formName].validate((valid) => {
						if (valid) {
							var self = this;
							$.ajax({
								type: 'POST',
								async: false,
								url: serve_url + "updateuser",
								data: JSON.stringify(this.editform),
								success: function(res) {
									console.log(res)
									self.getUsers();
									if (res == "true") {
										self.$message({
											message: '修改成功',
											type: 'success'
										});
									} else {
										self.$message.error('修改失败');
									}

									self.resetForm('editform');
									self.EditFormVisible = false;
								}
							})
						} else {
							console.log('error submit!!');
							return false;
						}
					});
				},
			},
			created() {
				this.getUsers();
			}
		})
	</script>
</html>
