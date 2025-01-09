<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
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
			<title>已离职员工</title>
		</head>

		<body>
			<%@ page import="bean.User" %>
				<%User user=new User(); user=(User)request.getSession().getAttribute("user");%>
					<%if((!user.getRole().equals("管理员"))||user.getRole()==null){
						response.sendRedirect("/z-index/power_error.jsp");%>
						<%} %>

							<div id="app">
								<div class="container">
									<div class="row">
										<div class="col-md-3">
											<h1 class="mt-3">欢迎你
												<%=user.getName() %>
											</h1>
										</div>
										<div class="col-md-2">
											<el-button type="primary" @click="goToManager()" class="mt-5"
												round>返回上页</el-button>
										</div>
									</div>
									<el-table
										:data="tableData.filter(data => !search || data.name.toLowerCase().includes(search.toLowerCase()))"
										style="width: 100%">
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
										<el-table-column label="性别" prop="gender">
										</el-table-column>
										<el-table-column align="right">
											<template slot="header" slot-scope="scope">
												<el-input v-model="search" size="mini" placeholder="输入关键字搜索" />
											</template>
											<template slot-scope="scope">
												<el-button size="mini"
													@click="handleRecover(scope.$index, scope.row)">恢复</el-button>
												<el-button size="mini" type="danger"
													@click="handleDelete(scope.$index, scope.row)">删除</el-button>
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
						EditFormVisible: false,
						form: {
							name: '',
							role: '',
							idcard: '',
							account: ''
						},
						editform: {
							id: '',
							name: '',
							role: '',
							idcard: '',
							account: '',
							password: ''
						},
					}
				},
				methods: {
				//恢复员工
				handleRecover(index, row) {
					console.log(row.id);

					this.$confirm('是否将用户' + row.name + '恢复?', '提示', {
						confirmButtonText: '确定',
						cancelButtonText: '取消',
						type: 'warning'
					}).then(() => {
						var self = this;
						$.ajax({
							type: 'POST',
							async: false,
							url: serve_url + "recover",
							data: JSON.stringify({
								"id": row.id
							}),
							success: function(res) {
								console.log(res)
								if (res == "true") {
									self.getEmployeelog();
									self.$message({
										message: '操作成功',
										type: 'success'
									});
								} else {
									self.$message.error('操作失败');
								}
								self.dialogFormVisible = false;
							}
						})
					}).catch(() => {
						this.$message({
							type: 'info',
							message: '已取消操作'
						});
					});
				},

					//删除员工
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
								url: serve_url + "deleteemployeelog",
								data: JSON.stringify({
									"id": row.id
								}),
								success: function (res) {
									console.log(res)
									if (res == "true") {
										self.getEmployeelog();
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
					//进入管理员界面
					goToManager() {
						window.location.href = '<%=request.getContextPath()%>/manager.jsp';
					},
					//获取已离职员工
					getEmployeelog() {
						var self = this;
						$.ajax({
							type: 'get',
							async: false,
							dataType: 'JSON',
							url: serve_url + "listall_deployeelog",
							success: function (res) {
								self.receive_users(res);
							}
						})
					},
					//关闭弹出窗口
					cancel() {
						this.dialogFormVisible = false;
						this.resetForm('form');
					},
					resetForm(formName) {
						this.$refs[formName].resetFields();
					},
				},
				created() {
					this.getEmployeelog();
				}
			})
		</script>

		</html>