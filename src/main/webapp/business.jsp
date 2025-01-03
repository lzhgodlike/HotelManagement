<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8" %>
<%@ page errorPage="/power_error.jsp" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script src="static/vue/vue.js"></script>
    <script src="static/vue/vue-router.js"></script>
    <link rel="stylesheet" type="text/css" href="static/bootstrap/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="static/element-ui-2.14.0/index.css"/>
    <script src="https://cdn.bootcdn.net/ajax/libs/element-ui/2.15.14/index.js"></script>
    <script src="static/database.js" type="text/javascript"></script>
    <script src="static/jquery-3.5.1.min.js"></script>
    <title>欢迎登录预约管理系统</title>
</head>
<body>
<%@ page import="bean.User" %>
<%
    User user = new User();
    user = (User) request.getSession().getAttribute("user");
%>
<%
    if ((!user.getRole().equals("普通业务员")) || user.getRole() == null) {
        response.sendRedirect("/z-index/power_error.jsp");
%>
<%} %>
<div id="app">
    <!--提车信息  -->
    <el-dialog title="提车" :visible.sync="dialogFormVisible">
        <el-form ref="pickifo" :model="pickifo" :rules="rules">
            <el-form-item label="预约编号" prop="sub_id" :label-width="formLabelWidth">
                <el-input :disabled="true" v-model="pickifo.sub_id" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="客户姓名" prop="customer_name" :label-width="formLabelWidth">
                <el-input :disabled="true" v-model="pickifo.customer_name" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="客户身份证号码" prop="customer_idcard" :label-width="formLabelWidth">
                <el-input :disabled="true" v-model="pickifo.customer_idcard" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="车辆类型" prop="car_model" :label-width="formLabelWidth">
                <el-input :disabled="true" v-model="pickifo.car_model" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="车牌号" prop="car_number" :label-width="formLabelWidth">
                <el-input :disabled="true" v-model="pickifo.car_number" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="租借类型" prop="rent_type" :label-width="formLabelWidth">
                <el-input :disabled="true" v-model="pickifo.rent_type" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="提车时间" prop="pick_time" :label-width="formLabelWidth">
                <el-date-picker v-model="pickifo.pick_time" type="date" value-format="yyyy-MM-dd" placeholder="选择提车日期">
                </el-date-picker>
            </el-form-item>
            <el-form-item label="还车时间" prop="return_time" :label-width="formLabelWidth">
                <el-date-picker v-model="pickifo.return_time" type="date" value-format="yyyy-MM-dd"
                                placeholder="选择提车日期">
                </el-date-picker>
            </el-form-item>
            <el-form-item label="已交租金" prop="plan_rent" :label-width="formLabelWidth">
                <el-input type="number" v-model="pickifo.plan_rent" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="押金" prop="deposit" :label-width="formLabelWidth">
                <el-input type="number" v-model="pickifo.deposit" autocomplete="off"></el-input>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="cancle()">取 消</el-button>
            <el-button type="primary" @click="submitForm('pickifo')">确 定</el-button>
        </div>
    </el-dialog>
    <!--还车信息  -->
    <el-dialog title="还车" :visible.sync="returnFormVisible">
        <el-form ref="returnifo" :model="returnifo" :rules="rules">
            <el-form-item label="提车时间" prop="return_date" :label-width="formLabelWidth">
                <el-date-picker v-model="returnifo.return_date" type="date" value-format="yyyy-MM-dd"
                                placeholder="选择还车日期">
                </el-date-picker>
            </el-form-item>

        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="cancle()">取 消</el-button>
            <el-button type="primary" @click="upreturn('returnifo')">确 定</el-button>
        </div>
    </el-dialog>
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h1 class="mt-3">欢迎你
                    <%=user.getName() %>
                </h1>
            </div>
        </div>

        <div class="row">
            <div class="row">
                <el-card class="col-md-3" shadow="hover">
                    <el-button type="primary" @click="changto(1)" style="width:100%" class="button mt-1">车辆预约
                    </el-button>
                </el-card>
                <el-card class="col-md-3" shadow="hover">
                    <el-button type="primary" @click="changto(2)" style="width:100%" class="button mt-1">提车管理
                    </el-button>
                </el-card>
                <el-card class="col-md-3" shadow="hover">
                    <el-button type="primary" @click="changto(3)" style="width:100%" class="button mt-1">还车管理
                    </el-button>
                </el-card>
                <el-card class="col-md-3" shadow="hover">
                    <el-button type="primary" @click="changto(4)" style="width:100%" class="button mt-1">客户管理
                    </el-button>
                </el-card>
            </div>
            <div class="row">
                <!--预约表  -->
                <div v-show="box===1">
                    <el-button v-show="box===1" type="primary" @click="addSub()" class="mt-5" round>新增预约</el-button>
                    <el-table ref="sublist"
                              :data="sublist.filter(sublist => !search || sublist.customer_idcard.toLowerCase().includes(search.toLowerCase()))"
                              style="width: 100%">
                        <el-table-column prop="sub_id" label="编号" width="60">
                        </el-table-column>
                        <el-table-column prop="car_model" label="车型">
                        </el-table-column>
                        <el-table-column prop="car_number" label="车牌号" width="130">
                        </el-table-column>
                        <el-table-column prop="customer_name" label="客户姓名">
                        </el-table-column>
                        <el-table-column prop="customer_idcard" label="身份证号码">
                        </el-table-column>
                        <el-table-column prop="sub_date" label="预约日期" width="130">
                        </el-table-column>
                        <el-table-column prop="sub_get_date" label="预计提车" width="130">
                        </el-table-column>
                        <el-table-column prop="sub_return_date" label="预计还车" width="130">
                        </el-table-column>
                        <el-table-column prop="sub_status" label="状态" width="100" column-key="sub_status"
                                         :filters="[{text: '预约', value: '预约'}, {text: '已提车', value: '已提车'}, {text: '已结束', value: '已结束'}]"
                                         :filter-method="filterHandler">
                        </el-table-column>
                        <el-table-column align="center">
                            <template slot="header" slot-scope="scope">
                                <el-input v-model="search" placeholder="输入身份证号码"/>
                            </template>
                            <template slot-scope="scope">
                            </template>
                            <template slot-scope="scope">
                                <el-button :disabled="scope.row.sub_status!='预约'" type="danger"
                                           @click="handleDelete(scope.$index, scope.row)">删除
                                </el-button>
                                <el-button :disabled="scope.row.sub_status!='预约'"
                                           @click="handleEdit(scope.$index, scope.row)">提车
                                </el-button>
                            </template>
                        </el-table-column>
                    </el-table>
                </div>
                <!--提车表  -->
                <div v-show="box===2">
                    <el-table ref="picklist"
                              :data="picklist.filter(picklist => !search2 || picklist.customer_idcard.toLowerCase().includes(search2.toLowerCase()))"
                              style="width: 100%">
                        <el-table-column prop="pick_id" label="编号" width="60">
                        </el-table-column>
                        <el-table-column prop="car_model" label="车型" width="60">
                        </el-table-column>
                        <el-table-column prop="car_number" label="车牌号" width="130">
                        </el-table-column>
                        <el-table-column prop="customer_name" label="客户姓名">
                        </el-table-column>
                        <el-table-column prop="customer_idcard" label="身份证号码">
                        </el-table-column>
                        <el-table-column prop="pick_time" label="提车日期" width="120">
                        </el-table-column>
                        <el-table-column prop="return_time" label="预计还车" width="120">
                        </el-table-column>
                        <el-table-column prop="deposit" label="押金" width="80">
                        </el-table-column>
                        <el-table-column prop="rent_type" label="租借类型" width="110">
                        </el-table-column>
                        <el-table-column prop="pick_status" label="状态" width="120" column-key="pics_status"
                                         :filters="[{text: '在租', value: '在租'}, {text: '已还车', value: '已还车'}]"
                                         :filter-method="filterHandler">
                        </el-table-column>
                        <el-table-column align="center">
                            <template slot="header" slot-scope="scope">
                                <el-input v-model="search2" placeholder="输入身份证号码"/>
                            </template>
                            <template slot-scope="scope">
                            </template>
                            <template slot-scope="scope">
                                <el-button :disabled="scope.row.pick_status!='在租'" size="big" type="danger"
                                           @click="returncar(scope.$index, scope.row)">还车
                                </el-button>

                            </template>
                        </el-table-column>
                    </el-table>
                </div>
                <!--还车表  -->
                <div v-show="box===3">
                    <el-table ref="returnlist"
                              :data="returnlist.filter(returnlist => !search3 || returnlist.customer_idcard.toLowerCase().includes(search3.toLowerCase()))"
                              style="width: 100%">
                        <el-table-column prop="return_id" label="编号" width="60">
                        </el-table-column>
                        <el-table-column prop="customer_idcard" label="客户身份证号">
                        </el-table-column>
                        <el-table-column prop="car_number" label="车牌号" width="130">
                        </el-table-column>
                        <el-table-column prop="return_date" label="还车日期">
                        </el-table-column>
                        <el-table-column prop="rent_type" label="租借方式">
                        </el-table-column>
                    </el-table>
                </div>
                <!--客户表  -->
                <div v-show="box===4">
                    <el-button v-show="box===4" type="primary" @click="addkh()" class="mt-5" round>增加客户</el-button>
                    <el-table ref="kuhulist"  :data="kuhulist.filter(kuhulist => !search4 || kuhulist.customer_idcard.toLowerCase().includes(search4.toLowerCase()))" style="width: 100%">
                        <el-table-column prop="customer_id" label="用户id" width="60"></el-table-column>
                        <el-table-column prop="customer_idcard" label="用户身份证号"></el-table-column>
                        <el-table-column prop="customer_name" label="用户名" width="130"></el-table-column>
                        <el-table-column prop="customer_unit" label="工作单位" width="130"></el-table-column>
                        <el-table-column prop="customer_phone" label="用户电话"></el-table-column>
                        <el-table-column prop="rgin_date" label="时间">


                        </el-table-column>
                        <el-table-column align="center">
                            <template slot="header" slot-scope="scope">
                            </template>
                            <template slot-scope="scope">
                            </template>
                            <template slot-scope="scope">
                                <el-button  size="big" type="danger"
                                           @click="xiugai(scope.row)">修改
                                </el-button>
                                <el-button  size="big" type="danger"
                                           @click="shanchu(scope.row.customer_id)">删除
                                </el-button>

                            </template>
                        </el-table-column>
                    </el-table>
                </div>
            </div>
        </div>
    </div>
    <el-dialog
            title="修改用户信息"
            :visible.sync="sfshVisiable"
            width="50%">
        <el-form ref="form" :model="customer" label-width="80px">
            <div style="margin-bottom: 20px;">
                <label>
                    <label>身份证号码:</label>
                    <el-input v-model="customer.customer_idcard" placeholder="请输入内容" style="width: 200px"></el-input>
                    <el-input v-model="customer.customer_id" type="hidden"></el-input>
                </label>
            </div>
            <div style="margin-left: 23px;margin-bottom: 20px;">
                <label>
                    <label>用户名:</label>
                    <el-input v-model="customer.customer_name" placeholder="请输入内容" style="width: 200px"></el-input>
                </label>
            </div>
            <div style="margin-bottom: 20px;">
                <label>
                    <label> 工作单位:</label>
                    <el-input v-model="customer.customer_unit" placeholder="请输入内容" style="width: 200px"></el-input>
                </label>
            </div>
            <div style="margin-bottom: 20px;">
                <label>
                    <label>客户电话</label>
                    <el-input v-model="customer.customer_phone" placeholder="请输入内容" style="width: 200px"></el-input>
                </label>
            </div>
            <div style="margin-bottom: 20px;">
                <label>
                    <label> 注册时间:</label>
                    <el-input v-model="customer.rgin_date" placeholder="请输入内容" style="width: 200px" readonly="readonly"></el-input>
                </label>
            </div>

        </el-form>
        <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="shHandler(customer)">确 定</el-button>
      </span>
    </el-dialog>
    <el-dialog
            title="客户信息"
            :visible.sync="addkehu"
            width="50%">
        <el-form ref="form" :model="kh" label-width="80px">
            <div style="margin-bottom: 20px;">
                <label>
                    <label>身份证号码:</label>
                    <el-input v-model="kh.customer_idcard" placeholder="请输入内容" style="width: 200px"></el-input>
                </label>
            </div>
            <div style="margin-left: 23px;margin-bottom: 20px;">
                <label>
                    <label>用户名:</label>
                    <el-input v-model="kh.customer_name" placeholder="请输入内容" style="width: 200px"></el-input>
                </label>
            </div>
            <div style="margin-bottom: 20px;">
                <label>
                    <label> 工作单位:</label>
                    <el-input v-model="kh.customer_unit" placeholder="请输入内容" style="width: 200px"></el-input>
                </label>
            </div>
            <div style="margin-bottom: 20px;">
                <label>
                    <label> 电话:</label>
                    <el-input v-model="kh.customer_phone" placeholder="请输入内容" style="width: 200px"></el-input>
                </label>
            </div>
            <div style="margin-bottom: 20px;">
                <label>
                    <label> 注册时间:</label>
                    <el-input v-model="kh.rgin_date" placeholder="请输入内容" style="width: 200px" type="date"></el-input>
                </label>
            </div>

        </el-form>
        <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="KhaddExE(kh)">确 定</el-button>
      </span>
    </el-dialog>
</div>
</body>
<script>
    new Vue({
        el: "#app",
        data() {
            return {
                customer:{},
                kh:{
                    rgin_date:'',
                    customer_phone:'',
                    customer_unit:'',
                    customer_name:'',
                    customer_idcard:'',
                },
                customer_id:'',
                sfshVisiable: false,
                addkehu: false,
                box: 1,
                search: '',
                search2: '',
                search3: '',
                search4: '',
                sublist: [],
                picklist: [],
                returnlist: [],
                kuhulist: [],
                formLabelWidth: '120px',
                dialogFormVisible: false,
                returnFormVisible: false,
                returnifo: {
                    customer_idcard: '',
                    car_number: '',
                    car_model: '',
                    return_date: '',
                    pick_id: '',
                    rent_type: ''
                },
                pickifo: {
                    customer_idcard: '',
                    customer_name: '',
                    car_number: '',
                    pick_time: '',
                    return_time: '',
                    car_model: '',
                    plan_rent: '',
                    deposit: '',
                    sub_id: '',
                    rent_type: ''
                },
                rules: {
                    pick_time: [{
                        required: true,
                        message: '不可为空',
                        trigger: 'blur'
                    }],
                    return_time: [{
                        required: true,
                        message: '不可为空',
                        trigger: 'blur'
                    }],
                    plan_rent: [{
                        required: true,
                        message: '不可为空',
                        trigger: 'blur'
                    }],
                    deposit: [{
                        required: true,
                        message: '不可为空',
                        trigger: 'blur'
                    }],

                },
            }
        },
        methods: {

            /*添加客户信息*/
            KhaddExE(kehuxinxi){
                var self = this;

                if (kehuxinxi.customer_idcard==""){
                    self.$message.error('请认真填写数据');
                    return false;
                }   if (kehuxinxi.customer_name==""){
                    self.$message.error('请认真填写数据');
                    return false;
                } if (kehuxinxi.customer_unit==""){
                    self.$message.error('请认真填写数据');
                    return false;
                }if (kehuxinxi.customer_phone==""){
                    self.$message.error('请认真填写数据');
                    return false;
                }if (kehuxinxi.rgin_date==""){
                    self.$message.error('请认真填写数据');
                    return false;
                }
                console.log("kehuxinxi",kehuxinxi);
                $.ajax({
                    type: 'POST',
                    async: false,
                    url: serve_url + "customer?avr=add",
                    data:{
                        sfzhm:kehuxinxi.customer_idcard,
                        name:kehuxinxi.customer_name,
                        unit:kehuxinxi.customer_unit,
                        phone:kehuxinxi.customer_phone,
                        date:kehuxinxi.rgin_date
                    },
                    success: function (res) {
                        if (res>0) {
                            self.$message({
                                message: '添加成功',
                                type: 'success'
                            });
                            self.addkehu=false;
                        } else {
                            self.$message.error('添加失败');
                        }
                        self.getkehuall();
                    }
                })
            },
            addkh(){
              this.addkehu=true;
            },

            /*修改客户信息*/
            shHandler(kehu){
                var self = this;
                if (kehu.customer_idcard==""){
                    self.$message.error('请认真填写数据');
                    return false;
                }   if (kehu.customer_name==""){
                    self.$message.error('请认真填写数据');
                    return false;
                } if (kehu.customer_unit==""){
                    self.$message.error('请认真填写数据');
                    return false;
                }if (kehu.customer_phone==""){
                    self.$message.error('请认真填写数据');
                    return false;
                }if (kehu.rgin_date==""){
                    self.$message.error('请认真填写数据');
                    return false;
                }
                console.log("kehu",kehu.customer_id)
                console.log("kehu",kehu)

                $.ajax({
                    type: 'POST',
                    async: false,
                    url: serve_url + "customer?avr=update",
                    data:{
                        id:kehu.customer_id,
                        sfzhm:kehu.customer_idcard,
                        name:kehu.customer_name,
                        unit:kehu.customer_unit,
                        phone:kehu.customer_phone,
                       date:kehu.rgin_date
                    },
                    success: function (res) {
                        if (res>0) {
                            self.$message({
                                message: '修改成功',
                                type: 'success'
                            });
                            self.sfshVisiable=false;
                        } else {
                            self.$message.error('修改失败');
                        }
                        self.dialogFormVisible = false;
                        self.getkehuall();

                    }
                })
            },


            shanchu(id){
                var self = this;
                $.ajax({
                    type: 'POST',
                    async: false,
                    url: serve_url + "customer?avr=delete",
                    data:{
                        id:id
                    },

                    success: function (res) {
                        if (res>0) {
                            self.$message({
                                message: '删除成功',
                                type: 'success'
                            });
                        } else {
                            self.$message.error('删除失败');
                        }
                        self.getkehuall();

                    }
                })
            },
            xiugai(row){
                this.customer=row
                this.kehu=row
                console.log("数据", this.customer)
              this.sfshVisiable=true
            },
            //切换窗口
            changto(index) {
                if (index == this.box) {
                    return;
                }

                switch (index) {
                    case 1:
                        this.getallsub();
                        break;
                    case 2:
                        this.getallpick();
                        break;
                    case 3:
                        this.getAllreturn();
                        break;
                    case 4:
                        this.getkehuall();
                        break;
                }
                this.box = index;
            },
            //获取还车信息
            returncar(index, row) {
                console.log(row);
                this.returnFormVisible = true;
                this.returnifo = row;
            },
            //还车
            upreturn(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        var self = this;
                        var rd = new Date(this.returnifo.return_date);
                        var pd = new Date(this.pickifo.return_time);
                        if (rd < pd) {
                            alert("你不能在提车前还车");
                            return;
                        }
                        $.ajax({
                            type: 'POST',
                            async: false,
                            url: serve_url + "add_return",
                            data: JSON.stringify(
                                this.returnifo
                            ),
                            success: function (res) {
                                if (res == "true") {
                                    self.getallpick();
                                    self.$message({
                                        message: '还车成功',
                                        type: 'success'
                                    });
                                } else {
                                    self.$message.error('还车失败');
                                }
                                self.returnFormVisible = false;
                            }
                        })
                    }
                })
                console.log(this.returnifo);
            },
            //删除预约信息
            handleDelete(index, row) {
                console.log(row.sub_id);
                console.log(this.pickifo);
                var self = this;
                $.ajax({
                    type: 'POST',
                    async: false,
                    url: serve_url + "delete_sub",
                    data: JSON.stringify({
                        "sub_id": row.sub_id
                    }),
                    success: function (res) {
                        self.getallsub();
                        if (res == "true") {
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
            },
            //新增预约
            addSub() {
                window.location.href = "/z-index/sub.jsp"
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
            //打开提车信息窗口
            handleEdit(index, row) {
                console.log(row)
                this.pickifo = row;
                this.dialogFormVisible = true;
            },
            //获取所有预约信息
            getallsub() {
                var self = this;
                $.ajax({
                    type: 'get',
                    async: false,
                    dataType: 'JSON',
                    url: serve_url + "add_sub",
                    success: function (res) {
                        console.log("11231", res)
                        self.receive_subs(res);
                    }
                })
            },
            //接收所有预约信息
            receive_subs(res) {
                this.sublist = res;
                console.log(this.sublist);
            },
            //日期检测
            chcekdate() {
                if (this.pickifo.pick_time != "" && this.pickifo.return_time != "") {
                    var getd = new Date(this.pickifo.pick_time);
                    var retn = new Date(this.pickifo.return_time);
                    if (retn < getd) {
                        return false;
                    } else {
                        return true;
                    }
                }
            },
            //提交提车信息
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        if (!this.chcekdate()) {
                            alert("你不能先还车再提车");
                            return;
                        }
                        console.log(this.pickifo);
                        var self = this;
                        $.ajax({
                            type: 'POST',
                            async: false,
                            url: serve_url + "add_pick",
                            data: JSON.stringify(this.pickifo),
                            success: function (res) {
                                console.log(res)
                                self.getallsub();
                                if (res == "true") {
                                    self.$message({
                                        message: '提车成功',
                                        type: 'success'
                                    });
                                } else {
                                    self.$message.error('提车失败');
                                }
                                self.dialogFormVisible = false;
                            }
                        })
                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            },
            //关闭窗口
            cancle() {
                this.dialogFormVisible = false;
                this.returnFormVisible = false;
            },
            //获取所有提车信息
            getallpick() {
                var self = this;
                $.ajax({
                    type: 'get',
                    async: false,
                    dataType: 'JSON',
                    url: serve_url + "add_pick",
                    success: function (res) {
                        self.receive_picks(res);
                    }
                })
            },
            //接收提车信息
            receive_picks(res) {
                this.picklist = res;
                console.log(res)
            },
            //获取还车信息表
            getAllreturn() {
                var self = this;
                $.ajax({
                    type: 'get',
                    async: false,
                    dataType: 'JSON',
                    url: serve_url + "add_return",
                    success: function (res) {
                        self.receive_returns(res);
                    }
                })
            },

            /*获取客户信息表*/
            getkehuall() {
                var self = this;
                $.ajax({
                    type: 'get',
                    async: false,
                    dataType: 'JSON',
                    url: serve_url + "customer",
                    success: function (res) {
                        console.log("客户表", res)
                        self.kuhu(res);
                    }
                })
            },
            receive_returns(res) {
                this.returnlist = res;
            },
            kuhu(res) {
                this.kuhulist = res;
            }
        },
        mounted() {
            this.getallsub();
        }
    })
</script>
</html>
