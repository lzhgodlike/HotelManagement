<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<script src="static/vue/vue.js"></script>
		<script src="static/vue/vue-router.js"></script>
		<link rel="stylesheet" type="text/css" href="static/bootstrap/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="static/element-ui-2.14.0/index.css" />
		<script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.15.14/index.js"></script> 
		<!-- <script src="static/element-ui-2.14.0/index.js"></script> -->
		<script src="static/database.js" type="text/javascript"></script>
		<script src="static/jquery-3.5.1.min.js"></script>
		<title>欢迎进入预约管理系统</title>
	</head>
	<body>
		<div style="display:none">
			<%@ page import="bean.room" %>
			<%room troom = (room)request.getAttribute("troom"); %>
			<input id="room_id" v-model="room_id" value="<%=troom.getRoom_id() %>" />
			<%-- <input id="num" v-model="num" value="<%=tcar.getCar_number() %>" /> --%>
			<input id="room_model" v-model="room_model" value="<%=troom.getRoom_model() %>" />
			<input id="current_status" v-model="current_status" value="<%=troom.getCurrent_status() %>" />
			<%-- <input id="bought" v-model="bought" value="<%=tcar.getBought_time() %>" /> --%>
			 <input id="room_img" v-model="room_img" value="<%=troom.getRoom_img() %>" /> 
			  <%-- <input id="one_night_rent" v-model="one_night_rent" value="<%= troom.getOne_night_rent() %>" />
        <input id="one_month_rent" v-model="one_month_rent" value="<%= troom.getOne_month_rent() %>" /> --%>
    </div>
		</div>
		<div id="app">	
			<el-dialog title="预约房间" :visible.sync="dialogFormVisible">
				<el-form ref="form" :model="form" :rules="rules">
					<el-form-item label="姓名" prop="name" :label-width="formLabelWidth">
						<el-input v-model="form.name" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="工作单位" prop="job" :label-width="formLabelWidth">
						<el-input v-model="form.job" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="身份证号" prop="idcard" :label-width="formLabelWidth">
						<el-input v-model="form.idcard" autocomplete="off"></el-input>
					</el-form-item>
					<el-form-item label="电话号码" prop="phone" :label-width="formLabelWidth">
						<el-input v-model="form.phone" autocomplete="off"></el-input>
					</el-form-item>
					<!-- <el-form-item label="租借方式" prop="type" :label-width="formLabelWidth">
						<el-select v-model="form.type" placeholder="请选择租借方式">
							<el-option label="月租" value="月租"></el-option>
							<el-option label="日租" value="日租"></el-option>
						</el-select>
					</el-form-item> -->
					<el-form-item label="入住时间" prop="getdate" :label-width="formLabelWidth">
						<el-date-picker v-model="form.getdate" type="date" value-format="yyyy-MM-dd" placeholder="选择入住日期">
						</el-date-picker>
					</el-form-item>
					<el-form-item label="退房时间" prop="returndate" :label-width="formLabelWidth">
						<el-date-picker v-model="form.returndate" type="date" value-format="yyyy-MM-dd" placeholder="选择退房日期">
						</el-date-picker>
					</el-form-item>
				</el-form>
				<div slot="footer" class="dialog-footer">
					<el-button @click="cancel()">取 消</el-button>
					<el-button type="primary" @click="submitForm('form')">确 定</el-button>
				</div>
			</el-dialog>
			<div class="container">
				
				<div class="row">
					<div class="col-md-6 left">
						<div class="pic"><img style="max-height:200px;" :src="room_img" /></div>
						<el-descriptions class="margin-top" :column="3" border>
						    <el-descriptions-item>
						      <template slot="label">
						        <i class="el-icon-user"></i>
						        房间号
						        <br>
						      </template>
						      {{room_id}}
						    </el-descriptions-item>
						    <el-descriptions-item>
						      <template slot="label">
						        <i class="el-icon-info"></i>
						        房型
						      </template>
						      {{room_model}}
						    </el-descriptions-item>
						    <el-descriptions-item>
						      <template slot="label">
						        <i class="el-icon-question"></i>
						        状态
						      </template>
						     <el-tag size="small">{{status}}</el-tag>
						    </el-descriptions-item>
						    <!-- <el-descriptions-item>
						      <template slot="label">
						        <i class="el-icon-time"></i>
						        出厂时间
						      </template>
						      {{bought}}
						    </el-descriptions-item> -->
						   <!--  <el-descriptions-item>
						      <template slot="label">
						        <i class="el-icon-money"></i>
						        日租金
						      </template>
						      {{one_night_rent}}
						    </el-descriptions-item>
						    <el-descriptions-item>
						      <template slot="label">
						        <i class="el-icon-coin"></i>
						        月租金
						      </template>
						      {{one_month_rent}}
						    </el-descriptions-item>
						  </el-descriptions> -->
					</div>
					<div class="col-md-6">
						<el-button @click="showbox" :disabled="is" style="width:100%;margin-top:40px;height:150px" type="success">{{ispass}}</el-button>
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
	            room_id: '',
	            room_model: '',
	            status: '',
	            room_img: '',
	            one_night_rent: '',
	            one_month_rent: '',
	            ispass: '正在出租',
	            is: true,
	            dialogFormVisible: false,
	            formLabelWidth: '120px',
	            allright: false,
	            form: {
	                name: '',
	                idcard: '',
	                type: '日租',
	                job: '',
	                phone: '',
	                getdate: '',
	                returndate: ''
	            },
	            rules: {
	                name: [{
	                    required: true,
	                    message: '姓名不可为空',
	                    trigger: 'blur'
	                }],
	                job: [{
	                    required: true,
	                    message: '工作不可为空',
	                    trigger: 'blur'
	                }],
	                returndate: [{
	                    required: true,
	                    message: '日期不可为空',
	                    trigger: 'blur'
	                }],
	                getdate: [{
	                    required: true,
	                    message: '日期不可为空',
	                    trigger: 'blur'
	                }],
	                phone: [{
	                    required: true,
	                    message: '号码不可为空',
	                    trigger: 'blur'
	                }, {
	                    min: 11,
	                    max: 11,
	                    message: '电话号码必须为11位',
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
	                type: [{
	                    required: true,
	                    message: '请选择方式',
	                    trigger: 'blur'
	                }]
	            },
	        }
	    },
	    methods: {
	        getElementValue(id) {
	            const element = document.getElementById(id);
	            return element ? element.value : '';
	        },
	        //检查日期是否合理
	        checkdate() {
	            if (this.form.getdate != "" && this.form.returndate != "") {
	                var getd = new Date(this.form.getdate);
	                var retn = new Date(this.form.returndate);
	                var today = new Date();
	                if (getd < today) {
	                    return "gs"
	                } else if (retn < getd) {
	                    return "rs"
	                }
	            }
	        },
	        //提交预约信息
	        submitForm(formName) {
	            var self = this;
	            this.$refs[formName].validate((valid) => {
	                if (valid) {
	                    if (self.checkdate() == "gs") {
	                        alert("你不能在过去预约");
	                        return
	                    } else if (self.checkdate() == "rs") {
	                        alert("你不能先入住后预约");
	                        return
	                    } else {
	                    	var sub_ifo = {
	                    		    "customer_name": this.form.name,
	                    		    "customer_idcard": this.form.idcard,
	                    		    "room_model": this.room_model,
	                    		    "sub_date": new Date(),
	                    		    "sub_get_date": new Date(this.form.getdate), // 使用 Date 对象解析日期
	                    		    "sub_return_date": new Date(this.form.returndate), // 使用 Date 对象解析日期
	                    		    "sub_status": "已预约",
	                    		    "room_id": this.room_id,
	                    		    
	                    		}
	                        var customer_ifo = {
	                            "customer_name": this.form.name,
	                            "customer_idcard": this.form.idcard,
	                            "customer_unit": this.form.job,
	                            "customer_phone": this.form.phone,
	                            "regin_date": new Date()
	                        }
	                        //var self = this;
	                        $.ajax({
	                            type: 'POST',
	                            async: false,
	                            url: serve_url + "add_customer1",
	                            data: JSON.stringify(customer_ifo),
	                            success: function(res) {
	                            self.addSub(sub_ifo); 
	                           console.log(sub_ifo);
	                            }
	                        })
	                    }
	                }
	            })
	        },
	        //新增入住信息
	        addSub(subifo) {
	            var self = this;
	            console.log(subifo)
	            $.ajax({
	                type: 'POST',
	                async: false,
	                url: serve_url + "add_sub1",
	                data: JSON.stringify(subifo),
	                success: function(res) {
	                    if(res=="true"){
	                        alert("预约成功");
	                        self.changestatus();
	                    }else{
	                        alert("预约失败,预约信息有误");
	                    }
	                }
	            })
	        },
	        //刷新页面
	        changestatus(){
	            this.is = false;
	            this.dialogFormVisible = false;
	            this.dialogFormVisible = false;
	            console.log(this.is)
	            location.reload();
	        },
	        //获取车辆价格
	        findprice(res) {
	            for (let i = 0; i < res.length; i++) {
	                if (res[i].car_model == this.model) {
	                    this.rent_day = res[i].rent_day;
	                    this.rent_month = res[i].rent_month;
	                }
	            }
	        },
	        //获得所有价格
	        getPrice() {
	            var self = this;
	            $.ajax({
	                type: 'get',
	                async: false,
	                dataType: 'JSON',
	                url: serve_url + "get_room_type",
	                success: function(res) {
	                    self.findprice(res);
	                }
	            })
	        },
	        showbox() {
	            this.dialogFormVisible = true;
	        },
	        cancel() {
	            this.dialogFormVisible = false;
	            this.resetForm('form');
	        },
	        resetForm(formName) {
	            this.$refs[formName].resetFields();
	        },
	    },
	    mounted() {
	        this.room_id = this.getElementValue("room_id");
	        this.room_model = this.getElementValue("room_model");
	        this.status = this.getElementValue("current_status");
	        if (this.status == "空闲") {
	            this.is = false;
	            this.ispass = "预约"
	        }
	        this.room_img = this.getElementValue("room_img");
	        this.one_night_rent = this.getElementValue("one_night_rent");
	        this.one_month_rent = this.getElementValue("one_month_rent");
	        this.getPrice();
	    }
	})
	</script>
	<style>
		body{
			background-size: cover;
			padding: 10px;	
			background: rgb(204, 204, 204);
			#app {
				width: 70%;
				margin: 0 auto;
				.left{
					display: flex;
					flex-direction: column; 
					justify-content: center;
					align-items: center;
					margin: 50px 0;
					.pic{
						margin-bottom: 30px;
					}
				}
			}
		}
	</style>
</html>
