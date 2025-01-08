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
    <title>欢迎进入房间预约系统</title>
</head>
<body>
    <div id="app">
        <div class="container">
            <div class="row">
                <h1 class="mt-3">欢迎进入房间预约系统</h1>
            </div>
            <div class="row ">
                <div class="col-md-3 left" style="border-right:solid 2px black">
                    <el-card v-for="(item,index) in allmodels" shadow="hover">
                        <h3 style="text-align:center">{{item.room_model}}</h3></br>
                        日租:&nbsp{{item.one_night_rent}}元</br>
                        月租:&nbsp{{item.one_month_rent}}元</br>
                        <el-button type="primary" @click="getroom(item.room_model)" style="width:100%" class="button mt-1">查询</el-button>
                    </el-card>
                </div>
                <div class="col-md-9">
                    <div class="row">
                        <el-card class="col-md-4 roombox" v-for="(item,index) in allrooms" shadow="hover">
                            <img @click="sub(item.room_id)" class="roomimg" :src="item.room_img" />
                            <p>房间号：{{item.room_id}}</p>
                            <p>状态：{{item.current_status}}</p>
                        </el-card>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>
    new Vue({
        el: '#app',
        data() {
            return {
                allmodels: [],
                allrooms: []
            }
        },
        methods: {
            //获取房型
            getmodels() {
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
                this.allmodels = res;
                console.log(this.allmodels)
            },
            //根据房型获得所有房间
            getroom(model) {
                var self = this;
                $.ajax({
                    type: 'get',
                    async: false,
                    dataType: 'JSON',
                    url: serve_url + "get_room_type?model=" + model,
                    success: function(res) {
                        self.receive_rooms(res);
                    }
                })
            },
            receive_rooms(res) {
                this.allrooms = res;
                console.log(this.allrooms);
            },
            //打开房间详细信息页
            sub(room_id){
            	window.location = serve_url + "get_room?room_id=" + room_id; 
            }
        },
        created() {
            this.getmodels();
        }
    })
</script>
<style>
    .wrapper {
        display: flex;
        width: 100%;
    }

    .left {
        height: 100vh;
        overflow: auto;
    }

    .right {
        height: 100vh;
        overflow: auto;
    }
    .roomimg {
        height: 200px;
        width: 200px;
        background-repeat: no-repeat;
        background-size: cover;
        margin-bottom: 20px;
    }
    .roombox {
        padding: 10px;
    }
</style>
</html>