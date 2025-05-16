# 项目导入指南

## 项目环境要求
- JDK 1.8
- Apache Tomcat 7.0+
- MySQL 8.0+
- Eclipse IDE 或其他Java Web IDE

## 导入步骤

### Eclipse导入步骤
1. 克隆项目到本地
   ```
   git clone https://github.com/lzhgodlike/HotelManagement.git
   ```

2. 在Eclipse中，选择File > Import > General > Existing Projects into Workspace

3. 选择项目根目录，点击Finish导入项目

4. 导入数据库脚本
   - 打开MySQL客户端工具（如MySQL Workbench、Navicat等）
   - 创建名为`hotel`的新数据库
   - 导入项目根目录中的`hotel.sql`文件

5. 配置数据库连接
   - 打开`src/main/java/util/DBConnection.java`文件
   - 检查并修改数据库连接信息（用户名、密码、URL等）

6. 配置Tomcat服务器
   - 右键点击项目 > Properties > Targeted Runtimes
   - 选择或配置Apache Tomcat 7.0+服务器

7. 部署并运行项目
   - 右键点击项目 > Run As > Run on Server
   - 在浏览器中访问 http://localhost:8080/hotel-management

### IntelliJ IDEA导入步骤
1. 克隆项目到本地
   ```
   git clone https://github.com/lzhgodlike/HotelManagement.git
   ```

2. 在IntelliJ IDEA中，选择File > Open，选择项目目录

3. 配置项目为Web项目
   - 右键点击项目 > Add Framework Support > JavaEE > Web Application

4. 导入数据库脚本（同上）

5. 配置数据库连接（同上）

6. 配置Tomcat服务器
   - 点击Run > Edit Configurations
   - 点击+号 > Tomcat Server > Local
   - 配置Tomcat路径
   - 在Deployment选项卡中，添加项目作为Web应用

7. 运行项目

## 常见问题

1. **找不到servlet-api.jar**
   - 确保已正确配置Tomcat服务器
   - 检查项目WEB-INF/lib目录是否包含servlet-api.jar

2. **数据库连接失败**
   - 检查MySQL服务是否启动
   - 验证数据库用户名和密码
   - 检查数据库URL是否正确（特别是端口号）

3. **编译错误**
   - 确保使用JDK 1.8
   - 检查是否缺少依赖项
