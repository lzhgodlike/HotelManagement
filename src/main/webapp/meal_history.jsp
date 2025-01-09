<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<!DOCTYPE html>
	<html lang="zh">

	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
		<link href="https://ai-public.mastergo.com/gen_page/tailwind-custom.css" rel="stylesheet" />
		<script
			src="https://cdn.tailwindcss.com/3.4.5?plugins=forms@0.5.7,typography@0.5.13,aspect-ratio@0.4.2,container-queries@0.1.1"></script>
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
			<!-- <header class="px-8 py-6 border-b">
			<div class="flex items-center mb-6">
				<button class="text-gray-600 hover:text-gray-900 !rounded-button whitespace-nowrap" onclick="window.history.back()">
					<i class="fas fa-arrow-left mr-2"></i>返回
				</button>
				<h1 class="text-2xl font-bold ml-4">餐饮订单记录</h1>
			</div>
			<div class="flex justify-between items-center mb-4">
				<div class="flex space-x-4">
					<button
						class="px-4 py-2 bg-primary text-white flex items-center !rounded-button whitespace-nowrap">
						<i class="fas fa-filter mr-2"></i>筛选
					</button>
					<div class="relative">
						<button
							class="px-4 py-2 bg-white border border-gray-300 flex items-center !rounded-button whitespace-nowrap">
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
		</header> -->
			<header class="px-8 py-6 border-b">
				<div class="flex items-center mb-6">
					<button onclick="window.history.back()"
						class="text-gray-600 hover:text-gray-900 !rounded-button whitespace-nowrap">
						<i class="fas fa-arrow-left mr-2"></i>返回
					</button>
					<h1 class="text-2xl font-bold ml-4">餐饮订单记录</h1>
				</div>
				<div class="flex justify-between items-center mb-4">
					<div class="flex space-x-4">
						<div class="relative">
							<button id="filterButton" @click="toggleFilterDropdown"
								class="px-4 py-2 bg-primary text-white flex items-center !rounded-button whitespace-nowrap">
								<i class="fas fa-filter mr-2"></i>筛选
							</button>
							<div id="filterDropdown"
								class="hidden absolute left-0 top-12 w-64 bg-white border rounded-lg shadow-lg z-50 p-4">
								<div class="mb-4">
									<label class="block text-sm font-medium text-gray-700 mb-2">订单状态</label>
									<div class="space-y-2">
										<label class="flex items-center">
											<input type="checkbox" class="form-checkbox h-4 w-4 text-primary"
												value="completed" name="status" v-model="selectedStatusFilters">
											<span class="ml-2 text-sm text-gray-600">已完成</span>
										</label>
										<label class="flex items-center">
											<input type="checkbox" class="form-checkbox h-4 w-4 text-primary"
												value="processing" name="status" v-model="selectedStatusFilters">
											<span class="ml-2 text-sm text-gray-600">待配送</span>
										</label>
										<label class="flex items-center">
											<input type="checkbox" class="form-checkbox h-4 w-4 text-primary"
												value="cancelled" name="status" v-model="selectedStatusFilters">
											<span class="ml-2 text-sm text-gray-600">已取消</span>
										</label>
									</div>
								</div>
								<div class="mb-4">
									<label class="block text-sm font-medium text-gray-700 mb-2">订单时间</label>
									<div class="space-y-2">
										<label class="flex items-center">
											<input type="radio" name="timeRange" class="form-radio h-4 w-4 text-primary"
												value="today">
											<span class="ml-2 text-sm text-gray-600">今天</span>
										</label>
										<label class="flex items-center">
											<input type="radio" name="timeRange" class="form-radio h-4 w-4 text-primary"
												value="week">
											<span class="ml-2 text-sm text-gray-600">最近7天</span>
										</label>
										<label class="flex items-center">
											<input type="radio" name="timeRange" class="form-radio h-4 w-4 text-primary"
												value="month">
											<span class="ml-2 text-sm text-gray-600">最近30天</span>
										</label>
									</div>
								</div>
								<div class="flex justify-end space-x-2">
									<button
										class="px-3 py-1 border border-gray-300 text-gray-700 text-sm !rounded-button whitespace-nowrap"
										@click="resetFilters">重置</button>
									<button
										class="px-3 py-1 bg-primary text-white text-sm !rounded-button whitespace-nowrap"
										@click="applyFilters">确定</button>
								</div>
							</div>
						</div>
						<div class="relative">
							<button id="sortButton"
								class="px-4 py-2 bg-white border border-gray-300 flex items-center !rounded-button whitespace-nowrap">
								<span>排序方式</span>
								<i class="fas fa-chevron-down ml-2"></i>
							</button>
							<div id="sortDropdown"
								class="hidden absolute left-0 top-12 w-48 bg-white border rounded-lg shadow-lg z-50">
								<div class="py-1">
									<button class="w-full px-4 py-2 text-left text-sm text-gray-700 hover:bg-gray-100"
										onclick="sortOrders('time-desc')">时间降序</button>
									<button class="w-full px-4 py-2 text-left text-sm text-gray-700 hover:bg-gray-100"
										onclick="sortOrders('time-asc')">时间升序</button>
									<button class="w-full px-4 py-2 text-left text-sm text-gray-700 hover:bg-gray-100"
										onclick="sortOrders('amount-desc')">金额降序</button>
									<button class="w-full px-4 py-2 text-left text-sm text-gray-700 hover:bg-gray-100"
										onclick="sortOrders('amount-asc')">金额升序</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- <div id="filterTags" class="flex flex-wrap gap-2">
				
			</div> -->
				<div class="flex flex-wrap gap-2">
					<span v-for="(status, index) in activeStatusFilters" :key="'status-'+index"
						class="filter-tag px-3 py-1 rounded-full flex items-center text-sm">
						状态: {{ status.label }}
						<button class="ml-2" @click="removeStatusFilter(status.value)"><i
								class="fas fa-times"></i></button>
					</span>
					<span v-if="activeTimeFilter" class="filter-tag px-3 py-1 rounded-full flex items-center text-sm">
						时间: {{ activeTimeFilter.label }}
						<button class="ml-2" @click="removeTimeFilter"><i class="fas fa-times"></i></button>
					</span>
				</div>
			</header>
			<main class="p-8">
				<div class="space-y-4">
					<div class="order-card bg-white p-6 rounded-lg border" v-for="(history, index) in histories">
						<div class="flex justify-between items-start mb-4">
							<div>
								<p class="text-gray-600 text-sm">订单号：{{ history.serviceId }}</p>
								<p class="text-gray-600 text-sm">创建时间：{{ history.createTime }}</p>
							</div>
							<span class="px-3 py-1 rounded-full text-sm" :class="statusSelect(index)">{{ history.status
								}}</span>
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
							<div class="flex items-center gap-4">
								<button v-show="history.status == '待配送'" @click="completeOrder(history.serviceId)"
									class="px-4 py-2 border border-green-500 text-green-500 hover:bg-green-50 !rounded-button whitespace-nowrap">标记完成</button>

								<button v-show="history.status == '待配送'" @click="cancelOrder(history.serviceId)"
									class="px-4 py-2 border border-red-500 text-red-500 hover:bg-red-50 !rounded-button whitespace-nowrap">取消订单</button>
								<span class="font-bold">合计：¥ 136</span>
							</div>
						</div>
					</div>
				</div>
			</main>
			<footer class="fixed bottom-0 left-0 right-0 bg-white border-t px-8 py-4">
				<div class="max-w-[1440px] mx-auto flex justify-between items-center">
					<div class="flex space-x-4">
						<button
							class="px-4 py-2 bg-gray-100 text-gray-700 !rounded-button whitespace-nowrap">今天</button>
						<button
							class="px-4 py-2 bg-gray-100 text-gray-700 !rounded-button whitespace-nowrap">本周</button>
						<button
							class="px-4 py-2 bg-gray-100 text-gray-700 !rounded-button whitespace-nowrap">本月</button>
					</div>
					<div class="flex space-x-4">
						<button
							class="px-4 py-2 border border-gray-300 text-gray-700 flex items-center !rounded-button whitespace-nowrap">
							<i class="fas fa-download mr-2"></i>导出记录
						</button>
						<button
							class="px-4 py-2 bg-primary text-white flex items-center !rounded-button whitespace-nowrap">
							<i class="fas fa-headset mr-2"></i>联系客服
						</button>
					</div>
				</div>
			</footer>
		</div>
	</body>
	<script src="//unpkg.com/vue@2/dist/vue.js"></script>
	<script src="//unpkg.com/element-ui@2.15.14/lib/index.js"></script>
	<script>
		document.addEventListener('click', function(event) {
			if (!filterDropdown.contains(event.target) && !filterButton.contains(event.target)) {
				filterDropdown.classList.add('hidden');
				isFilterOpen = false;
			}
			if (!sortDropdown.contains(event.target) && !sortButton.contains(event.target)) {
				sortDropdown.classList.add('hidden');
				isSortOpen = false;
			}
		});
		new Vue({
			el: '#app',
			data() {
				return {
					histories: [],
					dialogVisible: false,
					selectedStatusFilters: [],
            		selectedTimeFilter: null,
					statusOptions: [
						{ label: '已完成', value: 'completed' },
						{ label: '待配送', value: 'processing' },
						{ label: '已取消', value: 'cancelled' }
					],
					timeOptions: [
						{ label: '今天', value: 'today' },
						{ label: '最近7天', value: 'week' },
						{ label: '最近30天', value: 'month' }
					],
				}
			},
			computed: {
				activeStatusFilters() {
					return this.statusOptions.filter(status => this.selectedStatusFilters.includes(status.value));
				},
				activeTimeFilter() {
					return this.timeOptions.find(time => time.value === this.selectedTimeFilter);
				}
			},
			methods: {
				// 重置筛选条件
				resetFilters(){
					const dropdown = document.getElementById('filterDropdown');
					const checkboxes = dropdown.querySelectorAll('input[type="checkbox"]');
					const radios = dropdown.querySelectorAll('input[type="radio"]');
					checkboxes.forEach(cb => cb.checked = false);
					radios.forEach(radio => radio.checked = false);
				},
				// 切换筛选下拉菜单
				toggleFilterDropdown() {
					var dropdown = document.getElementById('filterDropdown');
					if (dropdown.classList.contains('hidden')) {
						dropdown.classList.remove('hidden');
					} else {
						dropdown.classList.add('hidden');
					}
				},

				statusAsParam(status) {
					switch (status) {
						case 'processing':
							return '待配送';
						case 'completed':
							return '已完成';
						case 'cancelled':
							return '已取消';
					}
				},
				// 启动筛选功能，将筛选条件保存，并作为参数传递给后端接口，接收后端返回的订单列表
				applyFilters() {
					var self = this;
					self.toggleFilterDropdown();
					var statusFilters = [];
					document.querySelectorAll('input[name="status"]:checked').forEach(function (checkbox) {
						statusFilters.push(self.statusAsParam(checkbox.value));
					});
					var timeRangeCheckbox = document.querySelector('input[name="timeRange"]:checked');
					var timeRange = timeRangeCheckbox == null ? null : timeRangeCheckbox.value;
					self.resetFilters();
					// 调用后端接口获取符合筛选条件的订单列表

					$.ajax({
						type: 'post',
						async: false,
						dataType: 'JSON',
						url: serve_url + "ListMealHistories",
						data: {
							statuses: statusFilters.join(','),
							timeRange: timeRange
						},
						success: function (res) {
							self.receive_histories(res);
						}
					});
				},
				// 移除状态筛选
				removeStatusFilter(value) {
					this.selectedStatusFilters = this.selectedStatusFilters.filter(filter => filter !== value);
				},
				// 移除时间筛选
				removeTimeFilter() {
					this.selectedTimeFilter = null;
				},
				// 点击完成订单
				completeOrder(serviceId) {
					console.log("点击标记完成");
					this.$confirm('确定完成该订单吗?', '提示', {
						confirmButtonText: '确定',
						cancelButtonText: '取消',
						type: 'warning'
					}).then(() => {
						// 用户点击确认
						this.sendOrderStatusToBackend(serviceId, '已完成');
						// 重新获取订单列表
						this.getMealHistories();
					}).catch(() => {
						// 用户点击取消
						this.$message({
							type: 'info',
							message: '已取消完成'
						});
					});
				},
				// 点击取消订单
				cancelOrder(serviceId) {
					console.log("点击取消订单", serviceId);

					this.$confirm('确定要取消该订单吗?', '提示', {
						confirmButtonText: '确定',
						cancelButtonText: '取消',
						type: 'warning'
					}).then(() => {
						// 用户点击确认
						this.sendOrderStatusToBackend(serviceId, '已取消');
						// 重新获取订单列表
						this.getMealHistories();
					}).catch(() => {
						// 用户点击取消
						this.$message({
							type: 'info',
							message: '已取消删除'
						});
					});
				},
				// 发送订单状态到后端，同步到数据库
				sendOrderStatusToBackend(serviceId, newStatus) {
					console.log("发送到后端");
					var self = this;
					$.ajax({
						type: 'POST',
						async: false,
						dataType: 'JSON',
						url: serve_url + "UpdateMealHistoryStatus",
						data: {
							serviceId: serviceId,
							status: newStatus
						},
						success: function (res) {
							if (res.success) {
								self.$message({
									type: 'success',
									message: '订单状态更新成功'
								});
							} else {
								self.$message({
									type: 'error',
									message: '订单状态更新失败'
								});
							}
						}
					});
				},
				// 订单状态选择
				statusSelect(index) {
					switch (this.histories[index].status) {
						case '待配送':
							return 'status-processing';
						case '已完成':
							return 'status-completed';
						case '已取消':
							return 'status-cancelled';
					}
				},
				receive_histories(msg) {
					this.histories = msg;
					console.log(this.histories);
				},
				//获取历史订单信息
				getMealHistories() {
					var self = this;
					$.ajax({
						type: 'get',
						async: false,
						dataType: 'JSON',
						url: serve_url + "ListMealHistories",
						success: function (res) {

							self.receive_histories(res);
						}
					})
				},
			},
			created() {
				this.getMealHistories();
			}
		})
	</script>

	</html>