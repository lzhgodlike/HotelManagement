<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

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
		
		
<title>欢迎登录预约管理系统</title>
</head>
<body>
<div id="app">
    <el-form ref="loginForm" :model="form" :rules="rules" label-width="80px" class="login-box">
      <h3 class="login-title">欢迎登录租车管理系统</h3>
      <el-form-item label="账号" prop="username">
        <el-input type="text" placeholder="请输入账号" v-model="form.username"/>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input type="password" placeholder="请输入密码" v-model="form.password"/>
      </el-form-item>
      <el-form-item label="角色" prop="role">
      <el-select v-model="form.role" placeholder="请选择您的角色">
     <el-option
      v-for="item in options"
      :key="item.value"
      :label="item.label"
      :value="item.value">
    </el-option>
  </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" v-on:click="onSubmit('loginForm')">登录</el-button>
      </el-form-item>
    </el-form>

    <el-dialog
      title="温馨提示"
      :visible.sync="dialogVisible"
      width="30%"
      :before-close="handleClose">
      <span>请输入账号和密码并选择角色</span>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
      </span>
    </el-dialog>
    </div>
</body>
<script>
 new Vue({
        el: "#app",
        data: function () {
        	 return {
        		 options: [{
        	          value: '经理',
        	          label: '经理'
        	        }, {
        	          value: '管理员',
        	          label: '管理员'
        	        }, {
        	          value: '普通业务员',
        	          label: '普通业务员'
        	        }],
        		 form: {
        	          username: '',
        	          password: '',
        	          role:''
        	        },
        	     // 表单验证，需要在 el-form-item 元素中增加 prop 属性
        	        rules: {
        	          username: [
        	            {required: true, message: '账号不可为空', trigger: 'blur'}
        	          ],
        	          password: [
        	            {required: true, message: '密码不可为空', trigger: 'blur'}
        	          ],
        	          role: [
               	            {required: true, message: '请选择角色', trigger: 'blur'}
               	          ]
        	        },

        	        // 对话框显示和隐藏
        	        dialogVisible: false
               }
        },
        methods: {
        	handleClose:function(){
        		console.log("方法")
        	},
        	showbox:function(){
              this.$message.error('登录信息有误');
            },
            //提交登录信息
            onSubmit: function(formName) {
              // 为表单绑定验证功能
              this.$refs[formName].validate((valid) => {
                if (valid) {
                	console.log(this.form);
                	var self = this; 
                	$.ajax({
                		type:'POST',
                		async: false,
                		url:"login_check",
                		data:JSON.stringify({
                			account:this.form.username,
                			password:this.form.password,
                			role:this.form.role
                		}),
                		success:function(res){
                			console.log(res)
                			if(res!="has error"){
                				window.location.href = res; 
                			}else if(res=="has error"){
                				//console.log(res)
                				self.showbox();
                			}
                		}
                	})
                } else {
                  this.dialogVisible = true;
                  return false;
                }
              });
            },
            
          }
        
        })
 </script>
 <style lang="scss" scoped>
  .login-box {
    border: 1px solid #DCDFE6;
    width: 400px;
    margin: 180px auto;
    padding: 35px 35px 15px 35px;
    border-radius: 5px;
    -webkit-border-radius: 5px;
    -moz-border-radius: 5px;
    box-shadow: 0 0 25px #909399;
  }

  .login-title {
    text-align: center;
    margin: 0 auto 40px auto;
    color: #303133;
  }
</style>
</html>