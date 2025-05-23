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
							primary: '#409eff'
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
				color: rgb(64, 158, 255);
			}
		</style>
	</head>

	<body>
		<div class="max-w-[1440px] mx-auto bg-white min-h-screen" id="app">
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
								class="px-4 py-2 bg-primary text-white flex items-center hover:bg-blue-600 !rounded-button whitespace-nowrap">
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
<!-- 								<div class="mb-4"> -->
<!-- 									<label class="block text-sm font-medium text-gray-700 mb-2">订单时间</label> -->
<!-- 									<div class="space-y-2"> -->
<!-- 										<label class="flex items-center"> -->
<!-- 											<input type="radio" name="timeRange" class="form-radio h-4 w-4 text-primary" -->
<!-- 												value="today"> -->
<!-- 											<span class="ml-2 text-sm text-gray-600">今天</span> -->
<!-- 										</label> -->
<!-- 										<label class="flex items-center"> -->
<!-- 											<input type="radio" name="timeRange" class="form-radio h-4 w-4 text-primary" -->
<!-- 												value="week"> -->
<!-- 											<span class="ml-2 text-sm text-gray-600">最近7天</span> -->
<!-- 										</label> -->
<!-- 										<label class="flex items-center"> -->
<!-- 											<input type="radio" name="timeRange" class="form-radio h-4 w-4 text-primary" -->
<!-- 												value="month"> -->
<!-- 											<span class="ml-2 text-sm text-gray-600">最近30天</span> -->
<!-- 										</label> -->
<!-- 									</div> -->
<!-- 								</div> -->
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
<!-- 						<div class="relative"> -->
<!-- 							<button id="sortButton" -->
<!-- 								class="px-4 py-2 bg-white border border-gray-300 flex items-center !rounded-button whitespace-nowrap"> -->
<!-- 								<span>排序方式</span> -->
<!-- 								<i class="fas fa-chevron-down ml-2"></i> -->
<!-- 							</button> -->
<!-- 							<div id="sortDropdown" -->
<!-- 								class="hidden absolute left-0 top-12 w-48 bg-white border rounded-lg shadow-lg z-50"> -->
<!-- 								<div class="py-1"> -->
<!-- 									<button class="w-full px-4 py-2 text-left text-sm text-gray-700 hover:bg-gray-100" -->
<!-- 										onclick="sortOrders('time-desc')">时间降序</button> -->
<!-- 									<button class="w-full px-4 py-2 text-left text-sm text-gray-700 hover:bg-gray-100" -->
<!-- 										onclick="sortOrders('time-asc')">时间升序</button> -->
<!-- 									<button class="w-full px-4 py-2 text-left text-sm text-gray-700 hover:bg-gray-100" -->
<!-- 										onclick="sortOrders('amount-desc')">金额降序</button> -->
<!-- 									<button class="w-full px-4 py-2 text-left text-sm text-gray-700 hover:bg-gray-100" -->
<!-- 										onclick="sortOrders('amount-asc')">金额升序</button> -->
<!-- 								</div> -->
<!-- 							</div> -->
<!-- 						</div> -->
					</div>
				</div>
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
								<span class="text-xl">套餐名称：{{ history.packageName }}</span>
								<!-- <span>¥ 256</span> -->
							</div>
							<div class="flex justify-between">
								<span>{{ history.description }}</span>
								<!-- <span>¥ 68</span> -->
								<button @click="showModal(index)"
									class="px-4 py-2 bg-primary text-white rounded-button hover:bg-blue-600 whitespace-nowrap">
									<i class="fas fa-file-alt mr-2"></i>
									查看详情
									</button>
							</div>
						</div>
						<div class="flex justify-between items-center pt-4 border-t">
							<span class="text-gray-600">送餐时间：{{ history.deliveryTime }}</span>
							<div class="flex items-center gap-4">
								<button v-show="history.status == '待配送'" @click="completeOrder(history.serviceId)"
									class="px-4 py-2 border border-green-500 text-green-500 hover:bg-green-50 !rounded-button whitespace-nowrap">标记完成</button>

								<button v-show="history.status == '待配送'" @click="cancelOrder(history.serviceId)"
									class="px-4 py-2 border border-red-500 text-red-500 hover:bg-red-50 !rounded-button whitespace-nowrap">取消订单</button>
								<span class="font-bold">合计：¥ {{ history.price }}</span>
							</div>
						</div>
					</div>
				</div>
			</main>	
			<div id="modal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
                <div class="bg-white rounded-lg w-[600px] p-6">
                    <div class="flex justify-between items-center mb-6">
                        <h3 class="text-xl font-semibold" id="modalTitle">订单详情</h3>
                        <button @click="closeModal" class="text-gray-500 hover:text-gray-700">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <form id="travelForm" class="space-y-4" method="post" action="travelService">
						<div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">订单号</label>
                            <input type="tel" name="passagerPhone" v-model="detail.serviceId"
                                class="w-full px-3 py-2 border rounded-button focus:outline-none focus:ring-2 focus:ring-primary"
                                readonly>
                        </div>
						<div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">客户ID</label>
                            <input type="tel" name="passagerPhone" v-model="detail.customerId"
                                class="w-full px-3 py-2 border rounded-button focus:outline-none focus:ring-2 focus:ring-primary"
                                readonly>
                        </div>
						<div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">送餐时间</label>
                            <input type="tel" name="passagerPhone" v-model="detail.deliveryTime"
                                class="w-full px-3 py-2 border rounded-button focus:outline-none focus:ring-2 focus:ring-primary"
                                readonly>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">送餐房间号</label>
                            <input type="text" name="passagerName" v-model="detail.deliveryAddress"
                                class="w-full px-3 py-2 border rounded-button focus:outline-none focus:ring-2 focus:ring-primary"
                                readonly>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">订单创建时间</label>
                            <input type="text" name="passagerName" v-model="detail.createTime"
                                class="w-full px-3 py-2 border rounded-button focus:outline-none focus:ring-2 focus:ring-primary"
                                readonly>
                        </div>
                    </form>
                </div>
            </div>		
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
					detail:{},
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
				showModal(index) {
					var self = this;
					const modal = document.getElementById('modal');
					// 显示模态框
					modal.classList.remove('hidden');
					self.detail = self.histories[index];

				},
				closeModal() {
					const modal = document.getElementById('modal');
					modal.classList.add('hidden');
				},
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
					if(confirm("确定完成该订单吗？")){
						// 用户点击确认
						this.sendOrderStatusToBackend(serviceId, "已完成");

						// 重新获取订单列表
						this.getMealHistories();
					} else {
						console.log("取消操作");
					}
					console.log("点击标记完成");
					
				},
				// 点击取消订单
				cancelOrder(serviceId) {
					console.log("点击取消订单", serviceId);

					if(confirm('确定要取消该订单吗?')) {
						// 用户点击确认
						this.sendOrderStatusToBackend(serviceId, '已取消');
						// 重新获取订单列表
						this.getMealHistories();
					} else {
						// 用户点击取消
						this.$message({
							type: 'info',
							message: '已取消删除'
						});
					}
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
								alert('订单状态更新成功');
							} else {
								alert('订单状态更新失败');
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