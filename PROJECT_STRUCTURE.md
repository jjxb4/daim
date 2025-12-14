# 项目结构说明

## 目录结构

```
home-service-booking/
├── backend/                          # 后端项目
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/homeservice/
│   │   │   │   ├── HomeServiceApplication.java    # 启动类
│   │   │   │   ├── common/
│   │   │   │   │   └── Result.java               # 统一响应类
│   │   │   │   ├── config/
│   │   │   │   │   └── SecurityConfig.java       # Security配置
│   │   │   │   │   └── MybatisPlusConfig.java    # MyBatisPlus配置
│   │   │   │   ├── controller/                   # 控制器层
│   │   │   │   │   ├── AuthController.java       # 认证接口
│   │   │   │   │   ├── UserController.java       # 用户接口
│   │   │   │   │   ├── ServiceController.java    # 服务接口
│   │   │   │   │   ├── OrderController.java      # 订单接口
│   │   │   │   │   ├── ReviewController.java     # 评价接口
│   │   │   │   │   ├── AnnouncementController.java # 公告接口
│   │   │   │   │   ├── EmployeeController.java   # 家政人员接口
│   │   │   │   │   └── AdminController.java      # 管理员接口
│   │   │   │   ├── dto/                          # 数据传输对象
│   │   │   │   │   ├── LoginRequest.java
│   │   │   │   │   ├── LoginResponse.java
│   │   │   │   │   ├── RegisterRequest.java
│   │   │   │   │   ├── EmployeeRegisterRequest.java
│   │   │   │   │   ├── OrderRequest.java
│   │   │   │   │   ├── ReviewRequest.java
│   │   │   │   │   ├── ProfileUpdateRequest.java
│   │   │   │   │   ├── PasswordUpdateRequest.java
│   │   │   │   │   ├── EmployeeDashboardResponse.java
│   │   │   │   │   └── AdminDashboardResponse.java
│   │   │   │   ├── entity/                       # 实体类
│   │   │   │   │   ├── User.java
│   │   │   │   │   ├── Employee.java
│   │   │   │   │   ├── Service.java
│   │   │   │   │   ├── Order.java
│   │   │   │   │   ├── Review.java
│   │   │   │   │   └── Announcement.java
│   │   │   │   ├── mapper/                       # Mapper接口
│   │   │   │   │   ├── UserMapper.java
│   │   │   │   │   ├── EmployeeMapper.java
│   │   │   │   │   ├── ServiceMapper.java
│   │   │   │   │   ├── OrderMapper.java
│   │   │   │   │   ├── ReviewMapper.java
│   │   │   │   │   └── AnnouncementMapper.java
│   │   │   │   ├── service/                      # 服务层
│   │   │   │   │   ├── AuthService.java
│   │   │   │   │   ├── UserService.java
│   │   │   │   │   ├── ServiceService.java
│   │   │   │   │   ├── OrderService.java
│   │   │   │   │   ├── ReviewService.java
│   │   │   │   │   ├── AnnouncementService.java
│   │   │   │   │   ├── EmployeeService.java
│   │   │   │   │   └── AdminService.java
│   │   │   │   └── util/
│   │   │   │       └── JwtUtil.java              # JWT工具类
│   │   │   └── resources/
│   │   │       ├── application.yml               # 配置文件
│   │   │       ├── schema.sql                    # 数据库表结构
│   │   │       └── data.sql                      # 初始化数据
│   │   └── pom.xml                               # Maven配置
│
├── frontend/                         # 前端项目
│   ├── src/
│   │   ├── api/                                  # API接口
│   │   │   ├── auth.js
│   │   │   ├── user.js
│   │   │   ├── service.js
│   │   │   ├── order.js
│   │   │   ├── review.js
│   │   │   ├── announcement.js
│   │   │   ├── employee.js
│   │   │   └── admin.js
│   │   ├── assets/                               # 静态资源
│   │   ├── components/                           # 公共组件
│   │   ├── router/
│   │   │   └── index.js                          # 路由配置
│   │   ├── stores/
│   │   │   └── user.js                           # 用户状态管理
│   │   ├── utils/
│   │   │   └── request.js                        # Axios封装
│   │   ├── views/                                # 页面组件
│   │   │   ├── Login.vue                         # 登录页
│   │   │   ├── Register.vue                      # 用户注册页
│   │   │   ├── EmployeeRegister.vue              # 家政人员注册页
│   │   │   ├── user/                             # 用户端页面
│   │   │   │   ├── Layout.vue
│   │   │   │   ├── Home.vue
│   │   │   │   ├── Announcements.vue
│   │   │   │   ├── Services.vue
│   │   │   │   ├── ServiceDetail.vue
│   │   │   │   ├── Orders.vue
│   │   │   │   └── Profile.vue
│   │   │   ├── employee/                         # 家政人员端页面
│   │   │   │   ├── Layout.vue
│   │   │   │   ├── Dashboard.vue
│   │   │   │   ├── Orders.vue
│   │   │   │   ├── Services.vue
│   │   │   │   └── Profile.vue
│   │   │   └── admin/                            # 管理员端页面
│   │   │       ├── Layout.vue
│   │   │       ├── Dashboard.vue
│   │   │       ├── Users.vue
│   │   │       ├── Orders.vue
│   │   │       ├── Services.vue
│   │   │       └── Announcements.vue
│   │   ├── App.vue                               # 根组件
│   │   └── main.js                               # 入口文件
│   ├── package.json                              # 依赖配置
│   └── vite.config.js                            # Vite配置
│
├── doc/
│   └── 家政服务系统_需求开发文档.md              # 需求文档
├── README.md                                     # 项目说明
├── PROJECT_STRUCTURE.md                          # 项目结构说明
├── .gitignore                                    # Git忽略文件
└── start.sh                                      # 启动脚本
```

## 功能模块说明

### 1. 认证授权模块
- 用户登录
- 用户注册
- 家政人员注册
- JWT令牌认证

### 2. 用户端模块
- 首页展示
- 系统公告浏览
- 家政服务浏览
- 服务详情查看
- 服务预约
- 订单管理
- 订单取消
- 服务评价
- 个人资料管理
- 密码修改

### 3. 家政人员端模块
- 工作台统计
- 待接订单列表
- 接单操作
- 我的订单管理
- 订单完成
- 可接服务浏览
- 个人资料管理

### 4. 管理员端模块
- 控制台统计
- 用户管理(增删改查)
- 订单管理(查看、修改状态、删除)
- 服务管理(增删改查)
- 公告管理(增删改查)

## 数据库表说明

### users - 用户表
- 存储所有用户信息(普通用户、家政人员、管理员)
- 包含用户名、邮箱、密码、头像、用户类型、状态等字段

### employees - 家政人员表
- 存储家政人员的额外信息
- 包含服务类型、电话、入职日期、总接单数、总收入、平均评分等

### services - 服务表
- 存储家政服务项目信息
- 包含服务名称、类别、描述、价格、图片、状态等

### orders - 订单表
- 存储订单信息
- 包含订单号、用户ID、家政人员ID、服务ID、金额、状态、预约时间、地址等

### reviews - 评价表
- 存储用户对服务的评价
- 包含订单ID、用户ID、家政人员ID、评分、评价内容等

### announcements - 公告表
- 存储系统公告信息
- 包含标题、内容、状态、创建人等

## API接口说明

### 认证接口 (/api/auth)
- POST /login - 登录
- POST /register - 用户注册
- POST /employee-register - 家政人员注册

### 服务接口 (/api/services)
- GET /hot - 获取热门服务
- GET / - 获取服务列表
- GET /{id} - 获取服务详情
- GET /{id}/reviews - 获取服务评价

### 订单接口 (/api/orders)
- POST / - 创建订单
- GET / - 获取订单列表
- POST /{id}/cancel - 取消订单

### 评价接口 (/api/reviews)
- POST / - 创建评价

### 用户接口 (/api/user)
- GET /profile - 获取个人资料
- PUT /profile - 更新个人资料
- PUT /password - 修改密码

### 公告接口 (/api/announcements)
- GET / - 获取公告列表

### 家政人员接口 (/api/employee)
- GET /dashboard - 获取工作台数据
- GET /orders - 获取订单列表
- PUT /orders/{id}/accept - 接单
- PUT /orders/{id}/complete - 完成订单
- GET /available-services - 获取可接服务
- GET /profile - 获取个人资料
- PUT /profile - 更新个人资料

### 管理员接口 (/api/admin)
- GET /dashboard - 获取控制台数据
- GET /users - 获取用户列表
- POST /users - 添加用户
- PUT /users/{id} - 更新用户
- DELETE /users/{id} - 删除用户
- PUT /users/{id}/status - 更新用户状态
- GET /orders - 获取订单列表
- GET /orders/{id} - 获取订单详情
- PUT /orders/{id}/status - 更新订单状态
- DELETE /orders/{id} - 删除订单
- GET /services - 获取服务列表
- POST /services - 添加服务
- PUT /services/{id} - 更新服务
- DELETE /services/{id} - 删除服务
- PUT /services/{id}/status - 更新服务状态
- GET /announcements - 获取公告列表
- POST /announcements - 添加公告
- PUT /announcements/{id} - 更新公告
- DELETE /announcements/{id} - 删除公告
- PUT /announcements/{id}/status - 更新公告状态

