<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="zh">

    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
        <link href="https://ai-public.mastergo.com/gen_page/tailwind-custom.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/echarts/5.5.0/echarts.min.js"></script>
        <script
            src="https://cdn.tailwindcss.com/3.4.5?plugins=forms@0.5.7,typography@0.5.13,aspect-ratio@0.4.2,container-queries@0.1.1"></script>
        <script>
            tailwind.config = {
                theme: {
                    extend: {
                        colors: {
                            primary: '#4F46E5'
                        }
                    }
                }
            }
        </script>
    </head>

    <body>
        <div class="min-h-[1024px] w-[1440px] mx-auto">
            <header class="h-16 flex items-center px-8 border-b">
                <h1 class="text-2xl font-bold text-gray-800">中国旅游出行服务</h1>
                <nav class="ml-12">
                    <ul class="flex gap-8">
                        <li><a href="#" class="text-gray-600 hover:text-primary">首页</a></li>
                        <li><a href="#" class="text-gray-600 hover:text-primary">服务介绍</a></li>
                        <li><a href="#" class="text-gray-600 hover:text-primary">联系我们</a></li>
                    </ul>
                </nav>
            </header>
            <main class="p-8">
                <div class="bg-white rounded-lg shadow-sm p-6 mb-8">
                    <h2 class="text-xl font-semibold mb-4">选择目的地</h2>
                    <p class="text-gray-600 mb-6">点击地图上的省份，开始规划您的行程</p>
                    <div id="map" class="w-full h-[600px]"></div>
                </div>
            </main>
            <div id="modal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
                <div class="bg-white rounded-lg w-[600px] p-6">
                    <div class="flex justify-between items-center mb-6">
                        <h3 class="text-xl font-semibold" id="modalTitle">行程规划</h3>
                        <button onclick="closeModal()" class="text-gray-500 hover:text-gray-700">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <form id="travelForm" class="space-y-4" method="post" action="travelService">
                        <input type="hidden" name="province" id="province">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">姓名</label>
                            <input type="text" name="passagerName"
                                class="w-full px-3 py-2 border rounded-button focus:outline-none focus:ring-2 focus:ring-primary"
                                required>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">联系电话</label>
                            <input type="tel" name="passagerPhone"
                                class="w-full px-3 py-2 border rounded-button focus:outline-none focus:ring-2 focus:ring-primary"
                                pattern="[0-9]{11}" required>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">出发日期</label>
                            <input type="date" name="date"
                                class="w-full px-3 py-2 border rounded-button focus:outline-none focus:ring-2 focus:ring-primary"
                                required>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">出行方式</label>
                            <div class="grid grid-cols-3 gap-4">
                                <button type="button"
                                    class="px-4 py-2 border !rounded-button hover:border-primary hover:text-primary text-gray-600 whitespace-nowrap transport-mode"
                                    data-mode="train">
                                    <i class="fas fa-train mr-2"></i>火车
                                </button>
                                <button type="button"
                                    class="px-4 py-2 border !rounded-button hover:border-primary hover:text-primary text-gray-600 whitespace-nowrap transport-mode"
                                    data-mode="plane">
                                    <i class="fas fa-plane mr-2"></i>飞机
                                </button>
                                <button type="button"
                                    class="px-4 py-2 border !rounded-button hover:border-primary hover:text-primary text-gray-600 whitespace-nowrap transport-mode"
                                    data-mode="bus">
                                    <i class="fas fa-bus mr-2"></i>客运
                                </button>
                            </div>
                            <input type="hidden" name="transportType" id="transportMode" required>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">终点站</label>
                            <div class="relative">
                                <button type="button" id="destinationBtn"
                                    class="w-full px-3 py-2 border !rounded-button focus:outline-none focus:ring-2 focus:ring-primary text-left text-gray-600 bg-white flex justify-between items-center">
                                    <span id="selectedDestination">请选择终点站</span>
                                    <i class="fas fa-chevron-down"></i>
                                </button>
                                <div id="destinationList"
                                    class="hidden absolute z-10 w-full mt-1 bg-white border rounded-button shadow-lg max-h-60 overflow-y-auto">
                                </div>
                            </div>
                            <input type="hidden" name="destination" id="destination" required>
                        </div>
                        
                        <div>
                            <button type="submit"
                                class="w-full bg-primary text-white py-2 !rounded-button hover:bg-primary/90 whitespace-nowrap">提交行程需求</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
        	// 获取id为map的元素，并用echarts初始化
            const chart = echarts.init(document.getElementById('map'));
            const modal = document.getElementById('modal');
            const modalTitle = document.getElementById('modalTitle');
            const travelForm = document.getElementById('travelForm');
            const transportModes = document.querySelectorAll('.transport-mode');
            const transportModeInput = document.getElementById('transportMode');
            const destinationBtn = document.getElementById('destinationBtn');
            const destinationList = document.getElementById('destinationList');
            const selectedDestination = document.getElementById('selectedDestination');
            const destinationInput = document.getElementById('destination');
            const province = document.getElementById('province');
            const cityData = {
                '北京市': ['东城区', '西城区', '朝阳区', '丰台区', '石景山区', '海淀区', '门头沟区', '房山区', '通州区', '顺义区', '昌平区', '大兴区', '怀柔区', '平谷区', '密云区', '延庆区'],
                '天津市': ['和平区', '河东区', '河西区', '南开区', '河北区', '红桥区', '东丽区', '西青区', '津南区', '北辰区', '武清区', '宝坻区', '滨海新区', '宁河区', '静海区', '蓟州区'],
                '河北省': ['石家庄市', '唐山市', '秦皇岛市', '邯郸市', '邢台市', '保定市', '张家口市', '承德市', '沧州市', '廊坊市', '衡水市'],
                '山西省': ['太原市', '大同市', '阳泉市', '长治市', '晋城市', '朔州市', '晋中市', '运城市', '忻州市', '临汾市', '吕梁市'],
                '内蒙古自治区': ['呼和浩特市', '包头市', '乌海市', '赤峰市', '通辽市', '鄂尔多斯市', '呼伦贝尔市', '巴彦淖尔市', '乌兰察布市', '兴安盟', '锡林郭勒盟', '阿拉善盟'],
                '辽宁省': ['沈阳市', '大连市', '鞍山市', '抚顺市', '本溪市', '丹东市', '锦州市', '营口市', '阜新市', '辽阳市', '盘锦市', '铁岭市', '朝阳市', '葫芦岛市'],
                '吉林省': ['长春市', '吉林市', '四平市', '辽源市', '通化市', '白山市', '松原市', '白城市', '延边朝鲜族自治州'],
                '黑龙江省': ['哈尔滨市', '齐齐哈尔市', '鸡西市', '鹤岗市', '双鸭山市', '大庆市', '伊春市', '佳木斯市', '七台河市', '牡丹江市', '黑河市', '绥化市', '大兴安岭地区'],
                '上海市': ['黄浦区', '徐汇区', '长宁区', '静安区', '普陀区', '虹口区', '杨浦区', '闵行区', '宝山区', '嘉定区', '浦东新区', '金山区', '松江区', '青浦区', '奉贤区', '崇明区'],
                '江苏省': ['南京市', '无锡市', '徐州市', '常州市', '苏州市', '南通市', '连云港市', '淮安市', '盐城市', '扬州市', '镇江市', '泰州市', '宿迁市'],
                '浙江省': ['杭州市', '宁波市', '温州市', '嘉兴市', '湖州市', '绍兴市', '金华市', '衢州市', '舟山市', '台州市', '丽水市'],
                '安徽省': ['合肥市', '芜湖市', '蚌埠市', '淮南市', '马鞍山市', '淮北市', '铜陵市', '安庆市', '黄山市', '滁州市', '阜阳市', '宿州市', '六安市', '亳州市', '池州市', '宣城市'],
                '福建省': ['福州市', '厦门市', '莆田市', '三明市', '泉州市', '漳州市', '南平市', '龙岩市', '宁德市'],
                '江西省': ['南昌市', '景德镇市', '萍乡市', '九江市', '新余市', '鹰潭市', '赣州市', '吉安市', '宜春市', '抚州市', '上饶市'],
                '山东省': ['济南市', '青岛市', '淄博市', '枣庄市', '东营市', '烟台市', '潍坊市', '济宁市', '泰安市', '威海市', '日照市', '临沂市', '德州市', '聊城市', '滨州市', '菏泽市'],
                '河南省': ['郑州市', '开封市', '洛阳市', '平顶山市', '安阳市', '鹤壁市', '新乡市', '焦作市', '濮阳市', '许昌市', '漯河市', '三门峡市', '南阳市', '商丘市', '信阳市', '周口市', '驻马店市'],
                '湖北省': ['武汉市', '黄石市', '十堰市', '宜昌市', '襄阳市', '鄂州市', '荆门市', '孝感市', '荆州市', '黄冈市', '咸宁市', '随州市', '恩施土家族苗族自治州'],
                '湖南省': ['长沙市', '株洲市', '湘潭市', '衡阳市', '邵阳市', '岳阳市', '常德市', '张家界市', '益阳市', '郴州市', '永州市', '怀化市', '娄底市', '湘西土家族苗族自治州'],
                '广东省': ['广州市', '韶关市', '深圳市', '珠海市', '汕头市', '佛山市', '江门市', '湛江市', '茂名市', '肇庆市', '惠州市', '梅州市', '汕尾市', '河源市', '阳江市', '清远市', '东莞市', '中山市', '潮州市', '揭阳市', '云浮市'],
                '广西壮族自治区': ['南宁市', '柳州市', '桂林市', '梧州市', '北海市', '防城港市', '钦州市', '贵港市', '玉林市', '百色市', '贺州市', '河池市', '来宾市', '崇左市'],
                '海南省': ['海口市', '三亚市', '三沙市', '儋州市'],
                '重庆市': ['万州区', '涪陵区', '渝中区', '大渡口区', '江北区', '沙坪坝区', '九龙坡区', '南岸区', '北碚区', '綦江区', '大足区', '渝北区', '巴南区', '黔江区', '长寿区', '江津区', '合川区', '永川区', '南川区', '璧山区', '铜梁区', '潼南区', '荣昌区', '开州区', '梁平区', '武隆区'],
                '四川省': ['成都市', '自贡市', '攀枝花市', '泸州市', '德阳市', '绵阳市', '广元市', '遂宁市', '内江市', '乐山市', '南充市', '眉山市', '宜宾市', '广安市', '达州市', '雅安市', '巴中市', '资阳市', '阿坝藏族羌族自治州', '甘孜藏族自治州', '凉山彝族自治州'],
                '贵州省': ['贵阳市', '六盘水市', '遵义市', '安顺市', '毕节市', '铜仁市', '黔西南布依族苗族自治州', '黔东南苗族侗族自治州', '黔南布依族苗族自治州'],
                '云南省': ['昆明市', '曲靖市', '玉溪市', '保山市', '昭通市', '丽江市', '普洱市', '临沧市', '楚雄彝族自治州', '红河哈尼族彝族自治州', '文山壮族苗族自治州', '西双版纳傣族自治州', '大理白族自治州', '德宏傣族景颇族自治州', '怒江傈僳族自治州', '迪庆藏族自治州'],
                '西藏自治区': ['拉萨市', '日喀则市', '昌都市', '林芝市', '山南市', '那曲市', '阿里地区'],
                '陕西省': ['西安市', '铜川市', '宝鸡市', '咸阳市', '渭南市', '延安市', '汉中市', '榆林市', '安康市', '商洛市'],
                '甘肃省': ['兰州市', '嘉峪关市', '金昌市', '白银市', '天水市', '武威市', '张掖市', '平凉市', '酒泉市', '庆阳市', '定西市', '陇南市', '临夏回族自治州', '甘南藏族自治州'],
                '青海省': ['西宁市', '海东市', '海北藏族自治州', '黄南藏族自治州', '海南藏族自治州', '果洛藏族自治州', '玉树藏族自治州', '海西蒙古族藏族自治州'],
                '宁夏回族自治区': ['银川市', '石嘴山市', '吴忠市', '固原市', '中卫市'],
                '新疆维吾尔自治区': ['乌鲁木齐市', '克拉玛依市', '吐鲁番市', '哈密市', '昌吉回族自治州', '博尔塔拉蒙古自治州', '巴音郭楞蒙古自治州', '阿克苏地区', '克孜勒苏柯尔克孜自治州', '喀什地区', '和田地区', '伊犁哈萨克自治州', '塔城地区', '阿勒泰地区'],
                '台湾省': ['台北市', '新北市', '桃园市', '台中市', '台南市', '高雄市'],
                '香港特别行政区': ['中西区', '湾仔区', '东区', '南区', '油尖旺区', '深水埗区', '九龙城区', '黄大仙区', '观塘区', '荃湾区', '屯门区', '元朗区', '北区', '大埔区', '西贡区', '沙田区', '葵青区', '离岛区'],
                '澳门特别行政区': ['花地玛堂区', '圣安多尼堂区', '大堂区', '望德堂区', '风顺堂区', '嘉模堂区', '圣方济各堂区']
            };
            // let province = "";
            // 出行方式按钮点击效果的js实现
            transportModes.forEach(btn => {
                btn.addEventListener('click', () => {
                    transportModes.forEach(b => b.classList.remove('border-primary', 'text-primary'));
                    btn.classList.add('border-primary', 'text-primary');
                    transportModeInput.value = btn.dataset.mode;
                });
            });
            let isDestinationListOpen = false;
            function toggleDestinationList() {
                isDestinationListOpen = !isDestinationListOpen;
                destinationList.classList.toggle('hidden');
            }
            // 联动菜单：显示省份对应的地市
            function updateDestinationList(province) {
                const cities = cityData[province] || [];
                console.log("cities", cities);

                //             destinationList.innerHTML = cities.map(city => `
                //     <div class="px-3 py-2 hover:bg-gray-100 cursor-pointer destination-item">
                //         ${city}
                //     </div>
                // `).join('');
                destinationList.innerHTML = cities.map(function (city) {
                    return '<div class="px-3 py-2 hover:bg-gray-100 cursor-pointer destination-item">' +
                        city +
                        '</div>';
                }).join('');
                const items = document.querySelectorAll('.destination-item');
                items.forEach(item => {
                    item.addEventListener('click', () => {
                        selectedDestination.textContent = item.textContent;
                        destinationInput.value = item.textContent;
                        toggleDestinationList();
                    });
                });
            }
            destinationBtn.addEventListener('click', toggleDestinationList);
            // 点击表单区域之外的部分将会隐藏表单
            document.addEventListener('click', (e) => {
                if (!destinationBtn.contains(e.target) && !destinationList.contains(e.target)) {
                    destinationList.classList.add('hidden');
                    isDestinationListOpen = false;
                }
            });
            // 获取阿里云的地图效果
            fetch('https://geo.datav.aliyun.com/areas_v3/bound/100000_full.json')
                .then(res => res.json())
                .then(geoJson => {
                    echarts.registerMap('china', geoJson);
                    const option = {
                        animation: false,
                        backgroundColor: '#ffffff',
                        tooltip: {
                            trigger: 'item',
                            formatter: '{b}',
                            backgroundColor: 'rgba(255, 255, 255, 0.95)',
                            borderColor: '#e2e8f0',
                            textStyle: {
                                color: '#1f2937'
                            },
                            padding: [8, 12]
                        },
                        series: [{
                            name: '中国',
                            type: 'map',
                            map: 'china',
                            roam: true,
                            zoom: 1.2,
                            label: {
                                show: true,
                                fontSize: 12,
                                color: '#374151',
                                fontWeight: 500
                            },
                            itemStyle: {
                                areaColor: '#f3f4f6',
                                borderColor: '#e5e7eb',
                                borderWidth: 1,
                                shadowColor: 'rgba(0, 0, 0, 0.05)',
                                shadowBlur: 10,
                                shadowOffsetY: 2
                            },
                            emphasis: {
                                itemStyle: {
                                    areaColor: '#4F46E5',
                                    borderColor: '#4338ca',
                                    borderWidth: 1,
                                    shadowColor: 'rgba(79, 70, 229, 0.3)',
                                    shadowBlur: 20,
                                    shadowOffsetY: 4
                                },
                                label: {
                                    color: '#fff',
                                    fontWeight: 600
                                }
                            },
                            select: {
                                itemStyle: {
                                    areaColor: '#4F46E5',
                                    borderColor: '#4338ca'
                                },
                                label: {
                                    color: '#fff',
                                    fontWeight: 600
                                }
                            }
                        }]
                    };
                    // 设置版图的效果选项
                    chart.setOption(option);
                    chart.on('click', params => {
                        console.log("params", params);
                        province.value = params.name;
                        modalTitle.textContent = params.name + ` 行程规划`;
                        modal.classList.remove('hidden');
                        updateDestinationList(params.name);
                    });
                });
            function closeModal() {
                modal.classList.add('hidden');
            }
            // 提交表单的回调函数，将表单数据发送到TravelServiceServlet，并弹窗返回的响应信息
            travelForm.onsubmit = (e) => {
                e.preventDefault();
                console.log("travelForm", travelForm);

                const formData = new FormData(travelForm);
                const data = Object.fromEntries(formData);
                console.log("data", data);
                
                // 使用 AJAX 发送数据到 TravelServiceServlet
                fetch('./travelService', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                })
                    .then(response => response.text())
                    .then(message => {
                        alert(message);
                        closeModal();
                        travelForm.reset();
                        selectedDestination.textContent = '请选择终点站';
                        transportModes.forEach(btn => btn.classList.remove('border-primary', 'text-primary'));
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('记录出行信息失败');
                    });
                const message = `
行程信息已记录：
姓名：`+ data.name + `
联系电话：`+ data.phone + `
出发日期：`+ data.date + `
出行方式：`+ data.transportMode == 'train' ? '火车' : data.transportMode == 'plane' ? '飞机' : '客运' + `
终点站：`+ data.destination;
                alert(message);
                closeModal();
                travelForm.reset();
                selectedDestination.textContent = '请选择终点站';
                transportModes.forEach(btn => btn.classList.remove('border-primary', 'text-primary'));
            };
            window.onclick = (e) => {
                if (e.target === modal) {
                    closeModal();
                }
            };
        </script>
    </body>

    </html>