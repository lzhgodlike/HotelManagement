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
		<script src="static/database.js" type="text/javascript"></script>
		<script src="static/jquery-3.5.1.min.js"></script>
		<title>欢迎进入预约管理系统</title>
	</head>
	<body>
		<div id="app">
			<div class="container">
				<div class="row">
					<h1 class="mt-3">欢迎进入汽车预约系统</h1>
				</div>
				<div class="row ">
					<div class="col-md-3 left" style="border-right:solid 2px black">
						<el-card v-for="(item,index) in allmodels" shadow="hover">
							<h3 style="text-align:center">{{item.car_model}}</h3></br>
							日租:&nbsp{{item.rent_day}}元</br>
							月租:&nbsp{{item.rent_month}}元</br>
							<el-button type="primary" @click="getcar(item.car_model)" style="width:100%" class="button mt-1">查询</el-button>
						</el-card>
					</div>
					<div class="col-md-9">
						<div class="row">
							<el-card class="col-md-4 carbox" v-for="(item,index) in allcars" shadow="hover">
								<img @click="sub(item.car_number)" class="carimg" :src="item.car_img" />
								<p>车牌号：{{item.car_number}}</p>
								<p>购买时间：{{item.bought_time}}</p>
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
					allcars: []
				}
			},
			methods: {
				//获取车型
				getmodels() {
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
					this.allmodels = res;
					//console.log(this.allmodels)
				},
				//根据车型获得所有车辆
				getcar(model) {
					var self = this;
					$.ajax({
						type: 'get',
						async: false,
						dataType: 'JSON',
						url: serve_url + "get_car_model?model=" + model,
						success: function(res) {
							self.receive_cars(res);
						}
					})
				},
				receive_cars(res) {
					this.allcars = res;
					console.log(this.allcars);
				},
				//打开车辆详细信息页
				sub(num){
					window.location = serve_url + "get_car?number=" + num; 
				}
			},
			created() {
				this.getmodels();
				//this.getcar("丰田");
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
		.carimg{
			height:200px;
			width:200px;
			background-repeat: no-repeat;
    		background-size: cover;
    		margin-bottom: 20px;
		}
		.carbox{
	
			padding:10px;
		}
	</style>
