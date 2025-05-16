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
<script src="static/element-ui-2.14.0/index.js"></script>
<script src="static/database.js" type="text/javascript"></script>
<script src="static/jquery-3.5.1.min.js"></script>
<title>欢迎登录酒店信息管理系统</title>
</head>
<body>
    <%@ page import="bean.User,bean.room"%>
    <%
    User user = new User();
    room r = new room();
    user = (User) request.getSession().getAttribute("user");
    %>
    <%
    if ((!user.getRole().equals("经理")) || user.getRole() == null) {
        response.sendRedirect("/z-index/power_error.jsp");
    %>
    <%
    }
    %>
    <div id="app">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h1 class="mt-3" style="width:150%">
                        欢迎你，
                        <%=user.getName()%>
                        经理
                    </h1>
                </div>
                <div class="col-md-7"></div>
            </div>
            <div class="row">
                <div class="col-md-3 mt-3">
                    <el-card shadow="hover"> <el-button type="primary"
                        @click="changto(1)" style="width:100%" class="button mt-1">房间类型</el-button>
                    </el-card>
                    <el-card shadow="hover"> <el-button type="primary"
                        @click="changto(2)" style="width:100%" class="button mt-1">现有房间</el-button>
                    </el-card>
                    <el-card shadow="hover"> <el-button type="primary"
                        @click="changto(3)" style="width:100%" class="button mt-1">客户消费统计</el-button>
                    </el-card>
					<input  type="button" value="导出数据" class="export-button">
					<div class="col-md-2" style="margin-left: 75px">
                    	<el-button v-show="box===1" type="primary" @click="addRoom_model()"
                        	class="mt-5" round>添加房间类型</el-button>
                    	<el-button v-show="box===2" type="primary" @click="addRoom()"
                        	class="mt-5" round>添加房间信息</el-button>
                	</div>
                </div>
                
                <div class="col-md-9">
                
                	<!-- 这里是点击添加房间按钮后的页面 -->
                    <div v-show="box===1">
                        <el-dialog title="添加房间类型" :visible.sync="dialogFormVisible">
                        <el-form ref="addform" :model="addform" :rules="rules">
                        
                        	<el-form-item label="房间类型" prop="room_model":label-width="formLabelWidth"> 
                        		<el-input v-model="addform.room_model" autocomplete="off"></el-input> 
                        	</el-form-item> 
                        
                        	<el-form-item label="一晚租金" prop="one_night_rent" :label-width="formLabelWidth">
                        		<el-input v-model="addform.one_night_rent" autocomplete="off"></el-input>
                        	</el-form-item> 
                        
                        	<el-form-item label="一月租金" prop="one_month_rent" :label-width="formLabelWidth"> 
                        		<el-input v-model="addform.one_month_rent" autocomplete="off"></el-input> 
                        	</el-form-item> 
                        
                        </el-form>
                        <div slot="footer" class="dialog-footer">
                            <el-button @click="cancel()">取 消</el-button>
                            <el-button type="primary" @click="submitForm('addform')">确
                            定</el-button>
                        </div>
                        </el-dialog>

						<!-- 这里是点击编辑按钮后的修改房间类型信息出现的页面 -->
                        <el-dialog title="修改房间类型信息" :visible.sync="EditFormVisible">
                        <el-form ref="editform" :model="editform" :rules="rules">
                        
                        	<el-form-item label="房间类型" prop="room_model" :label-width="formLabelWidth"> 
                        		<el-input :disabled="true" v-model="editform.room_model" autocomplete="off"></el-input>
                        	</el-form-item> 
                        	
                        	<el-form-item label="一晚租金" prop="one_night_rent" :label-width="formLabelWidth"> 
                        		<el-input v-model="editform.one_night_rent" autocomplete="off"></el-input> 
                        	</el-form-item> 
                        	
                        	<el-form-item label="一月租金" prop="one_month_rent" :label-width="formLabelWidth">
                        		<el-input v-model="editform.one_month_rent" autocomplete="off"></el-input>
                        	</el-form-item> 
                        	
                        </el-form>
                        <div slot="footer" class="dialog-footer">
                            <el-button @click="cancel()">取 消</el-button>
                            <el-button type="primary" @click="submitUpdate('editform')">确
                            定</el-button>
                        </div>
                        </el-dialog>
                        
                        <!-- 这里是列表中显示房间类型的属性 -->
                        <div class="container">
                            <div class="row"></div>
                            <el-table :data="form.filter(form => !search || form.room_model.toLowerCase().includes(search.toLowerCase()))" style="width: 100%"> 
                            <el-table-column label="房间类型" prop="room_model"> </el-table-column> 
                            <el-table-column label="一晚租金" prop="one_night_rent"> </el-table-column> 
                            <el-table-column label="一月租金" prop="one_month_rent"> </el-table-column> 
                            <el-table-column align="right">
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
                    
                    <!-- 这里是点击添加房间信息后出现的页面 -->
                    <div v-show="box===2">
                        <el-dialog title="添加房间信息" :visible.sync="roomFormVisible">
                        <el-form ref="addroomform" :model="addroomform"> 
                        
                            <el-form-item label="房间号码" prop="room_id" :label-width="formLabelWidth">
                                <el-input v-model="addroomform.room_id" autocomplete="off"></el-input>
                            </el-form-item> 
                            
                            <el-form-item label="房间类型" prop="room_model" :label-width="formLabelWidth"> 
                                <el-input v-model="addroomform.room_model" autocomplete="off"></el-input> 
                            </el-form-item>
                            
                            <el-form-item label="房间总数量" prop="Room_total_number" :label-width="formLabelWidth">
                                <el-input type="number" v-model="addroomform.Room_total_number" autocomplete="off"></el-input>
                            </el-form-item>
                            
                            <el-form-item label="房间剩余数量" prop="Room_s_number" :label-width="formLabelWidth">
                                <el-input type="number" v-model="addroomform.Room_s_number" autocomplete="off"></el-input>
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
                                  <img v-if="addroomform.room_img" :src="imgPath(addroomform.room_img)" class="avatar">
                                  <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                </el-upload>
                            </div>
                            </el-form-item> 
                            <el-form-item label="目前状态" prop="current_status"
                                :label-width="formLabelWidth"> 
                                <el-select v-model="addroomform.current_status" placeholder="请选择目前状态">
                                <el-option value="在租"></el-option> 
                                <el-option value="空闲"></el-option>
                                </el-select> 
                            </el-form-item> 
                        </el-form>
                        <div slot="footer" class="dialog-footer">
                            <el-button @click="cancel()">取 消</el-button>
                            <el-button type="primary" @click="addnewroom">确 定</el-button>
                        </div>
                        </el-dialog>
                        
                        <!-- 这里是查看房间信息的页面 -->
                        <el-dialog title="查看房间信息" :visible.sync="ViewroomFormVisible">
                        <el-form ref="viewroomform" :model="viewroomform"> 
                        
                            <el-form-item label="房间号码" prop="room_id" :label-width="formLabelWidth">
                                <el-input v-model="viewroomform.room_id" autocomplete="off"></el-input>
                            </el-form-item> 
                            
                            <el-form-item label="房间类型" prop="room_model" :label-width="formLabelWidth"> 
                                <el-input v-model="viewroomform.room_model" autocomplete="off"></el-input> 
                            </el-form-item>
                            
                            <el-form-item label="房间总数量" prop="Room_total_number" :label-width="formLabelWidth">
                                <el-input type="number" v-model="viewroomform.Room_total_number" autocomplete="off"></el-input>
                            </el-form-item>
                            
                            <el-form-item label="房间剩余数量" prop="Room_s_number" :label-width="formLabelWidth">
                                <el-input type="number" v-model="viewroomform.Room_s_number" autocomplete="off"></el-input>
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
                                  <img v-if="viewroomform.room_img" :src="imgPath(viewroomform.room_img)" class="avatar">
                                  <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                </el-upload>
                            </div>
                            </el-form-item> 
                            <el-form-item label="目前状态" prop="current_status"
                                :label-width="formLabelWidth"> 
                                <el-select v-model="viewroomform.current_status" placeholder="请选择目前状态">
                                <el-option value="已预约"></el-option>
                                <el-option value="已入住"></el-option> 
                                <el-option value="空闲"></el-option>
                                </el-select> 
                            </el-form-item> 
                        </el-form>
                        </el-dialog>

                        <!-- 这里是页面中显示列表属性的部分 -->
                        <el-table :data="roomData.filter(data => !search || data.room_model.toLowerCase().includes(search.toLowerCase()) || data.room_id.toLowerCase().includes(search.toLowerCase()) || data.current_status.toLowerCase().includes(search.toLowerCase()))" style="width: 100%">                   
                            <el-table-column label="房间ID" prop="room_id"> </el-table-column> 
                            <el-table-column label="房间类型" prop="room_model"> </el-table-column> 
                            <el-table-column label="房间总数量" prop="Room_total_number"> </el-table-column> 
                            <el-table-column label="房间剩余数量" prop="Room_s_number"> </el-table-column> 
                            <el-table-column label="目前状态" prop="current_status"> </el-table-column> 
                            <el-table-column align="right">
                        		<template slot="header" slot-scope="scope">
                            		<el-input v-model="search" size="mini" placeholder="输入关键字搜索" />
                        		</template>
                        		<template slot-scope="scope">
                        			<el-button size="mini" type="danger" @click="ViewRoom(scope.$index, scope.row)">查看</el-button>
                            		<el-button :disabled="scope.row.current_status!='空闲'" size="mini" type="danger" @click="deleteroom(scope.$index, scope.row)">删除</el-button>
                        		</template>
                        	</el-table-column> 
                        </el-table>
                    </div>
                    
                    
                    <div v-show="box===3">
						<el-table :data="rentCase.filter(data => !search)" style="width: 100%">
							<el-table-column label="消费编号" prop="case_id"> </el-table-column>
							<el-table-column label="客户编号" prop="customer_id"> </el-table-column>
							<el-table-column label="客户身份证号" prop="customer_idcard"> </el-table-column>
							<el-table-column label="客户姓名" prop="customer_name"> </el-table-column>
							<el-table-column label="工作单位" prop="customer_unit"> </el-table-column>
							<el-table-column label="客户电话" prop="customer_phone"> </el-table-column>
							<el-table-column label="状态" prop="pick_status"> </el-table-column>
							<el-table-column label="押金" prop="deposit"> </el-table-column>
							<el-table-column label="餐饮服务" prop="food_services">
    							<template slot-scope="scope">
        							<span>{{ scope.row.food_services ? '是' : '否' }}</span>
    							</template>
							</el-table-column>
							<el-table-column label="出行服务" prop="mobility_services">
    							<template slot-scope="scope">
        							<span>{{ scope.row.mobility_services ? '是' : '否' }}</span>
    							</template>
							</el-table-column>
							<el-table-column label="消费金额" prop="amount_spent"> </el-table-column>
						</el-table>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <script>
        new Vue({
            el: "#app",
            data() {
                return {
                    box: 1,
                    d1:'',
                    d2:'',
                    search: '',
                    allrent:[],
                    total:'',
                    computed:false,
                    roomData:[],
                    addroomform:{
                        room_id:'',
                        room_model:'',
                        Room_total_number: 0,
                        Room_s_number: 0,
                        current_status:'',
                        room_img:''
                    },
                    viewroomform:{
                        room_id:'',
                        room_model:'',
                        Room_total_number: 0,
                        Room_s_number: 0,
                        current_status:'',
                        room_img:''
                    },
                    dialogFormVisible: false,
                    EditFormVisible: false,
                    roomFormVisible:false,
                    ViewroomFormVisible:false,
                    form: [],
                    addform: {
                        room_model: '',
                        one_night_rent: '',
                        one_month_rent: ''
                    },
                    editform: {
                        room_model: '',
                        one_night_rent: '',
                        one_month_rent: ''
                    },
                    formLabelWidth: '120px',
                    rules: {
                        room_model: [{
                            required: true,
                            message: '房间类型不可为空',
                            trigger: 'blur'
                        }],
                        one_night_rent: [{
                            required: true,
                            message: '一晚租金不可为空',
                            trigger: 'blur'
                        }],
                        one_month_rent: [{
                            required: true,
                            message: '一月租金不可为空',
                            trigger: 'blur'
                        }],
                    },
                    rentCase: [],
                }
            },
            methods: {
                imgPath(adminImage) {
                    return "http://localhost:8080/z-index/" + adminImage;
                },
                handleAvatarSuccess(res, file) {
                    console.log(111111);
                    this.addroomform.room_img = res.message;
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
                            this.getallRooms();
                            break;
                        case 3:
                            this.getRentCase();
                            break;
                    }
                    this.box = index;
                },
                //提交新房间信息
                addnewroom(){
                    console.log(this.addroomform);
                    var self = this;
                    $.ajax({
                        type: 'POST',
                        async: false,
                        url: serve_url + "addnewroom",
                        data: JSON.stringify(this.addroomform),
                        success: function(res) {
                            console.log(res)
                            self.getallRooms();
                            if (res == "true") {
                                self.$message({
                                    message: '增加成功',
                                    type: 'success'
                                });
                            } else {
                                self.$message.error('增加失败');
                            }
                        }
                    })
                },
                //打开房间编辑窗口
                Edit(index, row) {
                    console.log(row)
                    this.EditFormVisible = true;
                    this.editform = row;
                    
                },
                ViewRoom(index, row) {
                	console.log(row);
                	this.ViewroomFormVisible = true;
                	this.viewroomform = row;
                },
                //关闭所有的窗口
                cancel() {
                    this.EditFormVisible = false;
                    this.dialogFormVisible = false;
                    this.roomFormVisible = false;
                },
                //增加新房间类型
                addRoom_model() {
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
                //提交修改房间类型信息
                submitUpdate(formName){
                    this.$refs[formName].validate((valid) => {
                        if (valid) {
                            var self = this;
                            $.ajax({
                                type: 'POST',
                                async: false,
                                url: serve_url + "updateroommodel",
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
                //提交修改房间信息
                submitUpdateRoom(formName) {
                	this.$refs[formName].validate((valid) => {
                		if(valid) {
                			var self = this;
                			$.ajax({
                				type: 'POST', //Http请求类型
                				async: false,
                				url: serve_url + "updateroom",
                				data: JSON.stringify(this.editform),
                				success: function(res) {
                					console.log(res)
                					self.getallRooms();
                					if (res == "true") {
                						self.$message({
                							message: '修改成功',
                							type: 'success'
                						});
                					} else {
                						self.$message.error('修改失败');
                					}
                					
                					self.resetForm('viewroomform');
                					self.ViewroomFormVisible = false;
                				}
                			})
                		} else {
                			console.log('error submit!!!');
                			return false;
                		}
                	});
                },
                
              //提交新房间类型信息
                submitForm(formName) {
                	//表单验证
                    this.$refs[formName].validate((valid) => {
                        if (valid) {
                            var self = this;
                            $.ajax({
                                type: 'POST',
                                async: false,
                                url: serve_url + "addnewtype",
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
                //获取所有的房间类型
                getallModels() {
                    var self = this;
                    $.ajax({
                        type: 'get',
                        async: false,
                        dataType: 'JSON',
                        url: serve_url + "get_room_type",
                        success: function(res) {
                            self.receive_models(res);
                        }
                    })
                },
                receive_models(res) {
                    this.form = res;
                },
                
            
                receive_rent(res){
                    res.forEach( item => {
                        if(item.room_model != "total") this.allrent.push(item);
                        else this.total = item.rent
                    })
                    this.computed = true;
                },
                
                //获取所有房间信息
                getallRooms(){
                    var self = this;
                    $.ajax({
                        type: 'get',
                        async: false,
                        dataType: 'JSON',
                        url: serve_url + "getAllrooms",
                        success: function(res) {
                            self.receive_rooms(res);
                        }
                    })
                },
                //保存至roomData
                receive_rooms(res){
                    console.log("Received rooms data:", res); // 添加日志
                    this.roomData = res;
                    console.log("roomData:", this.roomData); // 添加日志
                },
                //打开增加房间窗口
                addRoom(){
                    this.roomFormVisible = true;
                },
                //删除房间
                deleteroom(index,row){
                    console.log(row.room_id);
                    var self = this;
                    $.ajax({
                        type: 'get',
                        async: false,
                        dataType: 'JSON',
                        url: serve_url + "addnewroom?num="+row.room_id,
                        success: function(res) {
                            self.$message({
                                            message: '删除成功',
                                            type: 'success'
                                        });
                            //再次调用重新获取
                            self.getallRooms();
                        }
                    })
                },
                searchModel(){
                    this.form = this.form.filter((e) => e.room_model.startWith(search))
                },
                //获取客户消费统计表
                getRentCase() {
                	var self = this;
                	$.ajax({
                		type: 'get',
                		async: false,
                		dataType: 'JSON',
                		url: serve_url + "getRentCase",
                		success: function(res) {
                			self.receive_case(res);
                		}
                	})
                },
                //刷新rentCase的状态
                receive_case(res) {
                	console.log("Received rent_case data:", res);
                	this.rentCase = res;
                	console.log("rentCase:", this.rentCase);
                }
			},
			mounted() {
				this.getallModels();
			}
		});
        //DOM加载完成后
        $(document).ready(function() {
            $("input[value='导出数据']").click(function () {
                if (confirm("是否确认导出数据?")) {
                    window.location.href = "/z-index/ExportData";
                }
            });
        });
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
	    border-color: #9933FA;
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
	  body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
      }

      .container {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      }

      .row {
        margin-bottom: 20px;
      }

      h1 {
        color: #333333;
      }

      .el-button {
        margin-top: 10px;
      }

      .el-card {
        margin-bottom: 10px;
      }

      .el-table {
        margin-top: 20px;
      }

      .dialog-footer {
        text-align: right;
      }
      .export-button {
    	background-color: #8A2BE2;
    	color: white;
    	border: none;
    	border-radius: 5px;
    	cursor: pointer;
    	font-size: 16px;
    	transition: background-color 0.3s ease;
    	padding: 10px 10px;
    	margin-left: 100px;
  	  }
  	  
  	  .export-button:hover {
    	background-color: #DDA0DD;
      }
      .export-button:active {
        background-color: #A020F0;
      }
      .button {
        background-color: #8A2BE2;
	  }

	  .button:hover {
    	background-color: #DDA0DD;
	  }
</style>
</html>