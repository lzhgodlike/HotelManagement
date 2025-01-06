<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
<link href="https://ai-public.mastergo.com/gen_page/tailwind-custom.css" rel="stylesheet"/>
<script src="https://cdn.tailwindcss.com/3.4.5?plugins=forms@0.5.7,typography@0.5.13,aspect-ratio@0.4.2,container-queries@0.1.1"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
			<script src="static/vue/vue.js"></script>
			<script src="static/vue/vue-router.js"></script>
			<link rel="stylesheet" type="text/css" href="static/bootstrap/bootstrap.min.css" />
			<link rel="stylesheet" type="text/css" href="static/element-ui-2.14.0/index.css" />
			<script src="static/element-ui-2.14.0/index.js"></script>
			<script src="static/database.js" type="text/javascript"></script>
			<script src="static/jquery-3.5.1.min.js"></script>
<script>
tailwind.config = {
theme: {
extend: {
colors: {
primary: '#4F46E5'
},
borderRadius: {
'none': '0px',
'sm': '2px',
DEFAULT: '4px',
'md': '8px',
'lg': '12px',
'xl': '16px',
'2xl': '20px',
'3xl': '24px',
'full': '9999px',
'button': '4px'
}
}
}
}
</script>
<style>
body {
min-height: 1024px;
background-color: #F3F4F6;
}
.order-card {
transition: all 0.3s ease;
}
.order-card:hover {
transform: translateY(-2px);
box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}
.status-completed {
background-color: #DEF7EC;
color: #03543F;
}
.status-processing {
background-color: #E1EFFE;
color: #1E429F;
}
.status-cancelled {
background-color: #FDE8E8;
color: #9B1C1C;
}
.filter-tag {
background-color: #EEF2FF;
color: #4F46E5;
}
</style>
</head>
<body>
<div class="max-w-[1440px] mx-auto bg-white min-h-screen" id="app">
<header class="px-8 py-6 border-b">
<div class="flex items-center mb-6">
<button class="text-gray-600 hover:text-gray-900 !rounded-button whitespace-nowrap">
<i class="fas fa-arrow-left mr-2"></i>返回
</button>
<h1 class="text-2xl font-bold ml-4">餐饮订单记录</h1>
</div>
<div class="flex justify-between items-center mb-4">
<div class="flex space-x-4">
<button class="px-4 py-2 bg-primary text-white flex items-center !rounded-button whitespace-nowrap">
<i class="fas fa-filter mr-2"></i>筛选
</button>
<div class="relative">
<button class="px-4 py-2 bg-white border border-gray-300 flex items-center !rounded-button whitespace-nowrap">
<span>排序方式</span>
<i class="fas fa-chevron-down ml-2"></i>
</button>
</div>
</div>
</div>
<div class="flex flex-wrap gap-2">
<span class="filter-tag px-3 py-1 rounded-full flex items-center text-sm">
时间: 最近7天
<button class="ml-2"><i class="fas fa-times"></i></button>
</span>
<span class="filter-tag px-3 py-1 rounded-full flex items-center text-sm">
状态: 已完成
<button class="ml-2"><i class="fas fa-times"></i></button>
</span>
</div>
</header>
<main class="p-8">
<div class="space-y-4">
<div class="order-card bg-white p-6 rounded-lg border">
<div class="flex justify-between items-start mb-4">
<div>
<p class="text-gray-600 text-sm">订单号：SO20240315001</p>
<p class="text-gray-600 text-sm">2024-03-15 18:30</p>
</div>
<span class="status-completed px-3 py-1 rounded-full text-sm">已完成</span>
</div>
<div class="space-y-2 mb-4">
<div class="flex justify-between">
<span>香煎三文鱼配时蔬 × 2</span>
<span>¥ 256</span>
</div>
<div class="flex justify-between">
<span>法式洋葱汤 × 1</span>
<span>¥ 68</span>
</div>
</div>
<div class="flex justify-between items-center pt-4 border-t">
<span class="text-gray-600">共3件商品</span>
<span class="font-bold">合计：¥ 324</span>
</div>
</div>
<div class="order-card bg-white p-6 rounded-lg border">
<div class="flex justify-between items-start mb-4">
<div>
<p class="text-gray-600 text-sm">订单号：SO20240314002</p>
<p class="text-gray-600 text-sm">2024-03-14 12:45</p>
</div>
<span class="status-processing px-3 py-1 rounded-full text-sm">待配送</span>
</div>
<div class="space-y-2 mb-4">
<div class="flex justify-between">
<span>意大利肉酱面 × 1</span>
<span>¥ 88</span>
</div>
<div class="flex justify-between">
<span>凯撒沙拉 × 1</span>
<span>¥ 48</span>
</div>
</div>
<div class="flex justify-between items-center pt-4 border-t">
<span class="text-gray-600">共2件商品</span>
<div class="flex items-center gap-4">
<button class="px-4 py-2 border border-red-500 text-red-500 hover:bg-red-50 !rounded-button whitespace-nowrap">取消订单</button>
<span class="font-bold">合计：¥ 136</span>
</div>
</div>
</div>
<div class="order-card bg-white p-6 rounded-lg border">
<div class="flex justify-between items-start mb-4">
<div>
<p class="text-gray-600 text-sm">订单号：SO20240313003</p>
<p class="text-gray-600 text-sm">2024-03-13 19:15</p>
</div>
<span class="status-cancelled px-3 py-1 rounded-full text-sm">已取消</span>
</div>
<div class="space-y-2 mb-4">
<div class="flex justify-between">
<span>黑松露牛排 × 1</span>
<span>¥ 388</span>
</div>
</div>
<div class="flex justify-between items-center pt-4 border-t">
<span class="text-gray-600">共1件商品</span>
<span class="font-bold">合计：¥ 388</span>
</div>
</div>
</div>
</main>
<footer class="fixed bottom-0 left-0 right-0 bg-white border-t px-8 py-4">
<div class="max-w-[1440px] mx-auto flex justify-between items-center">
<div class="flex space-x-4">
<button class="px-4 py-2 bg-gray-100 text-gray-700 !rounded-button whitespace-nowrap">今天</button>
<button class="px-4 py-2 bg-gray-100 text-gray-700 !rounded-button whitespace-nowrap">本周</button>
<button class="px-4 py-2 bg-gray-100 text-gray-700 !rounded-button whitespace-nowrap">本月</button>
</div>
<div class="flex space-x-4">
<button class="px-4 py-2 border border-gray-300 text-gray-700 flex items-center !rounded-button whitespace-nowrap">
<i class="fas fa-download mr-2"></i>导出记录
</button>
<button class="px-4 py-2 bg-primary text-white flex items-center !rounded-button whitespace-nowrap">
<i class="fas fa-headset mr-2"></i>联系客服
</button>
</div>
</div>
</footer>
</div>
</body>
<script>
		new Vue({
			el: '#app',
			data() {
				return {
					tableData: [],
					search: '123',
					
				}
			},
			methods: {
				
			},
			created() {
			}
		})
	</script>
</html>
