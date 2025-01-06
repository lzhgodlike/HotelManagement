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
  <script>
    tailwind.config={theme:{extend:{colors:{primary:'#4A90E2'},borderRadius:{'none':'0px','sm':'2px',DEFAULT:'4px','md':'8px','lg':'12px','xl':'16px','2xl':'20px','3xl':'24px','full':'9999px','button':'4px'}}}}
  </script>
  <script src="static/vue/vue.js"></script>
	<script src="static/vue/vue-router.js"></script>
	<link rel="stylesheet" type="text/css" href="static/bootstrap/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="static/element-ui-2.14.0/index.css" />
	<script src="static/element-ui-2.14.0/index.js"></script>
	<script src="static/database.js" type="text/javascript"></script>
	<script src="static/jquery-3.5.1.min.js"></script>
  
</head>
<body class="bg-gray-50">
  <div class="min-h-[1024px] w-[1440px] mx-auto px-8 py-10" id="app">
    <h1 class="text-3xl font-bold text-gray-900 mb-8">酒店餐饮服务</h1>
    
    <div class="flex gap-8">
      <div class="w-2/3">
        <div class="grid grid-cols-2 gap-6">
          <div class="bg-white rounded shadow-sm overflow-hidden" v-for="(meal, index) in meals">
            <div class="h-[240px] w-full overflow-hidden">
              <img :src=meal.pictureSrc class="w-full h-full object-cover object-top" alt=meal.packageName/>
            </div>
            <div class="p-6">
              <h3 class="text-xl font-semibold mb-2" >{{ meal.packageName }}</h3>
              <p class="text-gray-600 mb-4">{{ meal.description }}</p>
              <div class="flex justify-between items-center">
                <span class="text-xl font-bold text-primary">¥ {{ meal.price }}</span>
                <button class="bg-primary text-white px-6 py-2 !rounded-button whitespace-nowrap" @click="selectMeal(index)">选择套餐</button>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <div class="w-1/3">
        <div class="bg-white rounded shadow-sm p-8">
          <h2 class="text-2xl font-bold mb-6">订餐信息</h2>
          <form class="space-y-6" action="mealOrder" method="post">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">姓名</label>
              <input type="text" class="w-full px-4 py-2 border border-gray-300 !rounded-button focus:border-primary focus:ring focus:ring-primary focus:ring-opacity-50" placeholder="请输入姓名" name="name"/>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">房间号</label>
              <input type="text" class="w-full px-4 py-2 border border-gray-300 !rounded-button focus:border-primary focus:ring focus:ring-primary focus:ring-opacity-50" placeholder="请输入房间号" name="deliveryAddress"/>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">手机号码</label>
              <input type="tel" class="w-full px-4 py-2 border border-gray-300 !rounded-button focus:border-primary focus:ring focus:ring-primary focus:ring-opacity-50" placeholder="请输入手机号码" name="phoneNumber"/>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">送餐时间</label>
              <input type="time" class="form-control" id="deliveryTime" name="deliveryTime" required>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">备注</label>
              <textarea class="w-full px-4 py-2 border border-gray-300 !rounded-button focus:border-primary focus:ring focus:ring-primary focus:ring-opacity-50" rows="3" placeholder="如有特殊要求请备注" name="remarks"></textarea>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">选定套餐</label>
              <input type="text" class="w-full px-4 py-2 border border-gray-300 !rounded-button focus:border-primary focus:ring focus:ring-primary focus:ring-opacity-50" placeholder="选定套餐" name="selectedMealName" id="selectedMealName" readonly/>
            </div>
            
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-2">套餐价格</label>
              <input type="text" class="w-full px-4 py-2 border border-gray-300 !rounded-button focus:border-primary focus:ring focus:ring-primary focus:ring-opacity-50" placeholder="套餐价格" name="selectedMealPrice" id="selectedMealPrice" readonly/>
            </div>
            
            <div>
              <input type="hidden" id="packageId" name="packageId" value=""/>
            </div>
            
            <div class="pt-4">
              <button class="w-full bg-primary text-white py-3 !rounded-button whitespace-nowrap font-medium" type="submit">提交订单</button>
            </div>
          </form>
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
				meals: [],
				search: '123',
			}
		},
		methods: {
			
			receive_packages(msg) {
				this.meals = msg;
				console.log(this.meals);
			},
			//获取套餐信息
			getPackages() {
				var self = this;
				$.ajax({
					type: 'get',
					async: false,
					dataType: 'JSON',
					url: serve_url + "listAllPackages",
					success: function(res) {
						self.receive_packages(res);
					}
				})
			},
	      // 选中套餐
	      selectMeal(index) {
	        console.log(index);
	        
	        document.getElementById('selectedMealName').value = this.meals[index].packageName;
	        document.getElementById('selectedMealPrice').value = this.meals[index].price;
	        document.getElementById('packageId').value = this.meals[index].packageId;
	      }
		},
		created() {
			this.getPackages();
		}
	})
</script>
</html>