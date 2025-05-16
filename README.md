# 酒店后台信息管理系统

## 项目介绍

这是一个基于Java Web开发的酒店管理系统，提供了房间预订、客户管理、餐饮服务、旅游服务等功能，帮助酒店高效地管理日常业务。

## 技术架构

* 后端：Java Servlet，JSP
* 数据库：MySQL
* 前端：HTML，CSS，JavaScript


## 安装部署

1. 克隆项目到本地
   ```
   git clone https://github.com/lzhgodlike/HotelManagement.git
   ```

2. 导入hotel.sql到MySQL数据库
   
3. 配置数据库连接信息（修改`src/main/java/util/DBConnection.java`中的设置）

4. 使用Eclipse或IntelliJ IDEA导入项目（项目包含了Eclipse配置文件，可直接导入）

5. 使用Tomcat或其他Servlet容器部署项目

> **详细步骤**: 请查看[项目导入指南](CONTRIBUTING.md)获取完整的导入和配置说明

## 主要功能

1. 客户管理 - 登记入住、退房处理、客户信息管理
2. 房间管理 - 房间状态查看、房型管理、房间维护
3. 餐饮服务 - 点餐系统、套餐管理
4. 旅游服务 - 旅游项目预订
5. 员工管理 - 员工信息管理、权限控制

## 参与贡献

1. Fork 本仓库
2. 创建新的功能分支 (`git checkout -b feature/your-feature`)
3. 提交您的更改 (`git commit -m 'Add some feature'`)
4. 推送到分支 (`git push origin feature/your-feature`)
5. 创建新的Pull Request


## 项目截图

(这里可以添加一些项目截图)

## 许可证

[MIT License](LICENSE)
