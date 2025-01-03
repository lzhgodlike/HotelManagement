<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page errorPage="/power_error.jsp"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script src="static/vue/vue.js"></script>
<script src="static/vue/vue-router.js"></script>
<link rel="stylesheet" type="text/css" href="static/bootstrap/bootstrap.min.css" />
<link rel="stylesheet" type="text/css" href="static/element-ui-2.14.0/index.css" />
<script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.14.0/index.js"></script>
<script src="static/database.js" type="text/javascript"></script>
<script src="static/jquery-3.5.1.min.js"></script>
<title>欢迎登录预约管理系统</title>
</head>
<body>
	<%@ page import="bean.User"%>
	<%
	User user = new User();
	user = (User) request.getSession().getAttribute("user");
	%>
	<%
	if ((!user.getRole().equals("管理员")) || user.getRole() == null) {
		response.sendRedirect("/z-index/power_error.jsp");
	%>
	<%
	}
	%>
	<div id="app">
		<div class="container">
			<div class="row">
				<div class="col-md-4">
					<h1 class="mt-3">
						欢迎你
						<%=user.getName()%>
					</h1>
				</div>
				<div class="col-md-7"></div>
				<div class="col-md-2">
					<el-button v-show="box===1" type="primary" @click="addCar_model()"
						class="mt-5" round>添加车型</el-button>
					<el-button v-show="box===2" type="primary" @click="addCar()"
						class="mt-5" round>添加车辆</el-button>
				</div>
			</div>
			<div class="row">
				<div class="col-md-3 mt-3">
					<el-card shadow="hover"> <el-button type="primary"
						@click="changto(1)" style="width:100%" class="button mt-1">车辆类型</el-button>
					</el-card>
					<el-card shadow="hover"> <el-button type="primary"
						@click="changto(2)" style="width:100%" class="button mt-1">现有车辆</el-button>
					</el-card>
					<el-card shadow="hover"> <el-button type="primary"
						@click="changto(3)" style="width:100%" class="button mt-1">租金统计</el-button>
					</el-card>
				</div>
				<div class="col-md-9">
					<div v-show="box===1">
						<el-dialog title="添加车型" :visible.sync="dialogFormVisible">
						<el-form ref="addform" :model="addform" :rules="rules">
						<el-form-item label="车型" prop="car_model"
							:label-width="formLabelWidth"> <el-input
							v-model="addform.car_model" autocomplete="off"></el-input> </el-form-item> <el-form-item
							label="日租金" prop="rent_day" :label-width="formLabelWidth">
						<el-input v-model="addform.rent_day" autocomplete="off"></el-input>
						</el-form-item> 
						<el-form-item label="月租金" prop="rent_month"
							:label-width="formLabelWidth"> <el-input
							v-model="addform.rent_month" autocomplete="off"></el-input> </el-form-item> </el-form>
						<div slot="footer" class="dialog-footer">
							<el-button @click="cancel()">取 消</el-button>
							<el-button type="primary" @click="submitForm('addform')">确
							定</el-button>
						</div>
						</el-dialog>

						<el-dialog title="修改车型信息" :visible.sync="EditFormVisible">
						<el-form ref="editform" :model="editform" :rules="rules">
						<el-form-item label="车型" prop="car_model"
							:label-width="formLabelWidth"> <el-input
							:disabled="true" v-model="editform.car_model" autocomplete="off"></el-input>
						</el-form-item> <el-form-item label="日租金" prop="rent_day"
							:label-width="formLabelWidth"> <el-input
							v-model="editform.rent_day" autocomplete="off"></el-input> </el-form-item> <el-form-item
							label="月租金" prop="rent_month" :label-width="formLabelWidth">
						<el-input v-model="editform.rent_month" autocomplete="off"></el-input>
						</el-form-item> </el-form>
						<div slot="footer" class="dialog-footer">
							<el-button @click="cancel()">取 消</el-button>
							<el-button type="primary" @click="submitUpdate('editform')">确
							定</el-button>
						</div>
						</el-dialog>
						<div class="container">
							<div class="row"></div>
							<el-table
								:data="form.filter(form => !search || form.car_model.toLowerCase().includes(search.toLowerCase()))"
								style="width: 100%"> <el-table-column label="车型"
								prop="car_model"> </el-table-column> <el-table-column
								label="日租金" prop="rent_day"> </el-table-column> <el-table-column
								label="月租金" prop="rent_month"> </el-table-column> <el-table-column
								align="right">
							<template slot="header" slot-scope="scope">
								<el-input v-model="search" size="mini" placeholder="输入关键字搜索" />
							</template>
							<template slot-scope="scope">
								<el-button size="mini" @click="Edit(scope.$index, scope.row)">编辑</el-button>
							</template>
							</el-table-column> 
							</el-table>
						</div>
					</div>
					<div v-show="box===2">
						<el-dialog title="添加车辆" :visible.sync="carFormVisible">
						<el-form ref="addcarform" :model="addcarform"> 
							<el-form-item label="车牌号" prop="car_number" :label-width="formLabelWidth">
								<el-input v-model="addcarform.car_number" autocomplete="off"></el-input>
							</el-form-item> 
							<el-form-item label="车辆型号" prop="car_model" :label-width="formLabelWidth"> 
								<el-input v-model="addcarform.car_model" autocomplete="off"></el-input> 
							</el-form-item>
							<el-form-item label="购买时间" prop="bought_time" :label-width="formLabelWidth">
								<div class="block">
									<el-date-picker value-format="yyyy-MM-dd"
										v-model="addcarform.bought_time" type="date"
										placeholder="选择日期时间"> 
									</el-date-picker>
								</div>
							</el-form-item>
							<el-form-item label="照片" :label-width="formLabelWidth">
							<div class="block">
								<el-upload
								  class="avatar-uploader"
								  action="fileUpload"
								  :show-file-list="false"
								  :on-success="handleAvatarSuccess"
								  :with-credentials="true"
								  enctype="multipart/form-data">
								  <img v-if="addcarform.car_img" :src="imgPath(addcarform.car_img)" class="avatar">
								  <i v-else class="el-icon-plus avatar-uploader-icon"></i>
								</el-upload>
							</div>
							</el-form-item> 
							<el-form-item label="目前状态" prop="current_status"
								:label-width="formLabelWidth"> 
								<el-select v-model="addcarform.current_status" placeholder="请选择目前状态">
								<el-option value="在租"></el-option> 
								<el-option value="空闲"></el-option>
								</el-select> 
							</el-form-item> 
						</el-form>
						<div slot="footer" class="dialog-footer">
							<el-button @click="cancel()">取 消</el-button>
							<el-button type="primary" @click="addnewcar">确 定</el-button>
						</div>
						</el-dialog>
						<el-table
							:data="carData.filter(data => !search || carData.car_number.toLowerCase().includes(search.toLowerCase()))"
							style="width: 100%"> <el-table-column label="车辆ID"
							prop="car_id"> </el-table-column> <el-table-column label="车牌号"
							prop="car_number"> </el-table-column> <el-table-column
							label="车辆型号" prop="car_model"> </el-table-column> <el-table-column
							label="购买时间" prop="bought_time"> </el-table-column> <el-table-column
							label="目前状态" prop="current_status"> </el-table-column> <el-table-column
							align="right">
						<template slot="header" slot-scope="scope">
							<el-input v-model="search" size="mini" placeholder="输入关键字搜索" />
						</template>
						<template slot-scope="scope">
							<el-button :disabled="scope.row.current_status!='空闲'" size="mini"
								type="danger" @click="cashcar(scope.$index, scope.row)">报废</el-button>
						</template>
						</el-table-column> </el-table>
					</div>
					<div v-show="box===3">
						<el-card class="box-card">
							<h2>租金统计</h2>
							<br>
							起始日期：<input type="text" v-model="d1" placeholder="请输入起始日期" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							终止日期：<input type="text" v-model="d2" placeholder="请输入终止日期" />&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							<el-table :data="allrent" style="width: 100%" v-if="computed"> 
								<el-table-column prop="car_model" label="类型" width="180"> </el-table-column> 
								<el-table-column prop="rent" label="租金" width="180"> </el-table-column> 
							</el-table>
							<el-button type="success" v-on:click="onSum()">计算租金</el-button>
							<p v-if="computed">共计:{{total}}元</p>
						</el-card>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
<script>
		new Vue({
			el: "#app",
			data() {
				return {
					box: 1,
					d1:'2024-01-01',
        		 	d2:'2024-01-20',
					tableData: [],
					search: '',
					allrent:[],
					total:'',
					computed:false,
					carData:[],
					addcarform:{
						car_number:'',
						car_model:'',
						bought_time:'',
						current_status:'',
						car_img:''
					},
					dialogFormVisible: false,
					EditFormVisible: false,
					carFormVisible:false,
					form: [],
					addform: {
						car_model: '',
						rent_day: '',
						rent_month: ''
					},
					editform: {
						car_model: '',
						rent_day: '',
						rent_month: ''
					},
					formLabelWidth: '120px',
					rules: {
						car_model: [{
							required: true,
							message: '车型不可为空',
							trigger: 'blur'
						}],
						rent_day: [{
							required: true,
							message: '日租金不可为空',
							trigger: 'blur'
						}],
						rent_month: [{
							required: true,
							message: '月租金不可为空',
							trigger: 'blur'
						}],
					},
				}
			},
			methods: {
				imgPath(adminImage) {
					return "http://localhost:8080/z-index/" + adminImage;
				},
				handleAvatarSuccess(res, file) {
					console.log(111111);
					this.addcarform.car_img = res.message;
				},
				changto(index) {
					if (index == this.box) {
						return;
					}

					switch (index) {
						case 1:
							this.getallModels();
							break;
						case 2:
							this.getallCars();
							break;
						case 3:
							//this.getRentCash();
							break;
					}
					this.box = index;
				},
				//提交新车信息
				addnewcar(){
					console.log(this.addcarform);
					var self = this;
					$.ajax({
						type: 'POST',
						async: false,
						url: serve_url + "addnewcar",
						data: JSON.stringify(this.addcarform),
						success: function(res) {
							console.log(res)
							self.getallModels();
							if (res == "true") {
								self.$message({
									message: '增加成功',
									type: 'success'
								});
							} else {
								self.$message.error('增加失败');
							}
							self.getallCars();
							//self.resetForm('editform');
							self.cancel();
						}
					})
				},
				//打开车辆编辑窗口
				Edit(index, row) {
					console.log(row)
					this.EditFormVisible = true;
					this.editform = row;
					
				},
				//关闭所有的窗口
				cancel() {
					this.EditFormVisible = false;
					this.dialogFormVisible = false;
					this.carFormVisible = false;
				},
				//增加新车型号
				addCar_model() {
					this.dialogFormVisible = true;
				},
				resetDateFilter() {
					this.$refs.filterTable.clearFilter('date');
				},
				clearFilter() {
					this.$refs.filterTable.clearFilter();
				},
				formatter(row, column) {
					return row.address;
				},
				filterTag(value, row) {
					return row.tag === value;
				},
				filterHandler(value, row, column) {
					const property = column['property'];
					return row[property] === value;
				},
				//提交修改信息
				submitUpdate(formName){
					this.$refs[formName].validate((valid) => {
						if (valid) {
							var self = this;
							$.ajax({
								type: 'POST',
								async: false,
								url: serve_url + "updatemodel",
								data: JSON.stringify(this.editform),
								success: function(res) {
									console.log(res)
									self.getallModels();
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
				//提交新车型信息
				submitForm(formName) {
					this.$refs[formName].validate((valid) => {
						if (valid) {
							var self = this;
							$.ajax({
								type: 'POST',
								async: false,
								url: serve_url + "addmodel",
								data: JSON.stringify(this.addform),
								success: function(res) {
									console.log(res)
									self.getallModels();
									if (res == "true") {
										self.$message({
											message: '添加成功',
											type: 'success'
										});
									} else {
										self.$message.error('添加失败');
									}

									self.resetForm('addform');
									self.dialogFormVisible = false;
								}
							})
						} else {
							console.log('error submit!!');
							return false;
						}
					});
				},
				//重置表单
				resetForm(formName) {
					this.$refs[formName].resetFields();
				},
				//获取所有的车辆型号
				getallModels() {
					var self = this;
					$.ajax({
						type: 'get',
						async: false,
						dataType: 'JSON',
						url: serve_url + "get_car_model",
						success: function(res) {

							self.receive_models(res);
						}
					})
				},
				receive_models(res) {
					this.form = res;
				},
				//计算租金
				onSum() {
					this.allrent = []
					var self = this;
					$.ajax({
						type: 'post',
						async: false,
						dataType:'JSON',
						url: serve_url +"sumservlet",
						data: JSON.stringify({
							d1: this.d1, //发送到服务器的数据，Object或String类型的参数，如果已经不是字符串，将自动转换为字符串格式。
							d2: this.d2,
						}),
						success: function(res) {
							self.receive_rent(res)
						}
					})
				},
				receive_rent(res){
					res.forEach( item => {
						if(item.car_model != "total") this.allrent.push(item);
						else this.total = item.rent
					})
					this.computed = true;
				},
				//获取所有车辆信息
				getallCars(){
					var self = this;
					$.ajax({
						type: 'get',
						async: false,
						dataType: 'JSON',
						url: serve_url + "getAllcars",
						success: function(res) {
							self.receive_cars(res);
						}
					})
					
				},
				receive_cars(res){
					this.carData = res;
					console.log(this.carData)
				},
				//打开增加车辆窗口
				addCar(){
					this.carFormVisible = true;
				},
				//报废车辆
				cashcar(index,row){
					console.log(row.car_id);
					var self = this;
					$.ajax({
						type: 'get',
						async: false,
						dataType: 'JSON',
						url: serve_url + "addnewcar?num="+row.car_id,
						success: function(res) {
							self.$message({
											message: '报废成功',
											type: 'success'
										});
							self.getallCars();
						}
					})
				},
				searchModel(){
					this.form = this.form.filter((e) => e.car_model.startWith(search))
				}
			},
			mounted() {
				this.getallModels();
			}
		})
	</script>
	<style>
	  .avatar-uploader .el-upload {
	    border: 1px dashed #d9d9d9;
	    border-radius: 6px;
	    cursor: pointer;
	    position: relative;
	    overflow: hidden;
	  }
	  .avatar-uploader .el-upload:hover {
	    border-color: #409EFF;
	  }
	  .avatar-uploader-icon {
	    font-size: 28px;
	    color: #8c939d;
	    width: 178px;
	    height: 178px;
	    line-height: 178px;
	    text-align: center;
	  }
	  .avatar {
	    width: 178px;
	    height: 178px;
	    display: block;
	  }
</style>
</html>
