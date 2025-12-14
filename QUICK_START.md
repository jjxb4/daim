# 快速启动指南

## 前置要求

- JDK 1.8+
- Maven 3.6+
- MySQL 8.0+
- Node.js 16+
- npm 或 yarn

## 快速启动步骤

### 1. 数据库配置

修改 `backend/src/main/resources/application.yml`:

```yaml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/home_service?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai
    username: root
    password: your_password  # 修改为你的MySQL密码
```

### 2. 初始化数据库

```bash
# 登录MySQL
mysql -u root -p

# 执行初始化脚本
source backend/src/main/resources/schema.sql
source backend/src/main/resources/data.sql
```

### 3. 启动后端

```bash
cd backend
mvn clean install
mvn spring-boot:run
```

后端将在 http://localhost:8080 启动

### 4. 启动前端

打开新终端:

```bash
cd frontend
npm install
npm run dev
```

前端将在 http://localhost:5173 启动

## 测试账户

### 管理员账户
- 用户名: admin
- 密码: admin123
- 登录类型: 管理员

### 普通用户
- 用户名: user1
- 密码: 123456
- 登录类型: 普通用户

### 家政人员
- 用户名: employee1
- 密码: 123456
- 登录类型: 家政人员

## 功能测试流程

### 1. 用户端测试
1. 使用 user1 账户登录
2. 浏览首页热门服务
3. 查看系统公告
4. 浏览家政服务列表
5. 点击服务详情
6. 预约服务(填写预约时间和地址)
7. 查看我的订单
8. 修改个人资料

### 2. 家政人员端测试
1. 使用 employee1 账户登录
2. 查看工作台统计数据
3. 查看待接订单列表
4. 接单
5. 查看我的订单
6. 完成订单
7. 查看可接服务列表
8. 修改个人资料

### 3. 管理员端测试
1. 使用 admin 账户登录
2. 查看控制台统计数据
3. 用户管理:
   - 查看用户列表
   - 添加新用户
   - 编辑用户信息
   - 禁用/启用用户
   - 删除用户
4. 订单管理:
   - 查看所有订单
   - 修改订单状态
   - 删除订单
5. 服务管理:
   - 查看服务列表
   - 添加新服务
   - 编辑服务信息
   - 启用/禁用服务
   - 删除服务
6. 公告管理:
   - 查看公告列表
   - 发布新公告
   - 编辑公告
   - 发布/下架公告
   - 删除公告

## 常见问题

### 1. 后端启动失败
- 检查MySQL是否启动
- 检查数据库连接配置是否正确
- 检查端口8080是否被占用

### 2. 前端启动失败
- 检查Node.js版本是否符合要求
- 删除 node_modules 重新安装: `rm -rf node_modules && npm install`
- 检查端口5173是否被占用

### 3. 登录失败
- 检查数据库中是否有测试账户
- 检查密码是否正确(测试账户密码已在data.sql中预设)
- 检查后端是否正常运行

### 4. 跨域问题
- 前端已配置代理,确保vite.config.js中的proxy配置正确
- 后端已配置CORS,确保SecurityConfig中的CORS配置正确

## API测试

可以使用Postman或curl测试API:

### 登录接口测试
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "password": "admin123",
    "userType": "admin"
  }'
```

### 获取服务列表
```bash
curl http://localhost:8080/api/services/hot
```

## 开发建议

1. 使用Chrome DevTools查看网络请求
2. 查看浏览器控制台的错误信息
3. 查看后端控制台的日志输出
4. 使用MySQL客户端查看数据库数据

## 技术支持

如遇到问题,请检查:
1. 后端日志: 查看控制台输出
2. 前端日志: 查看浏览器控制台
3. 数据库日志: 查看MySQL日志
4. 网络请求: 使用浏览器开发者工具查看

