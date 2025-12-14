#!/bin/bash

echo "======================================"
echo "家政服务系统启动脚本"
echo "======================================"

# 检查MySQL是否运行
echo "检查MySQL服务..."
if ! pgrep -x "mysqld" > /dev/null; then
    echo "MySQL未运行,请先启动MySQL服务"
    exit 1
fi

# 初始化数据库
echo "初始化数据库..."
mysql -u root -p < backend/src/main/resources/schema.sql
mysql -u root -p < backend/src/main/resources/data.sql

# 启动后端
echo "启动后端服务..."
cd backend
mvn clean install
mvn spring-boot:run &
BACKEND_PID=$!
cd ..

# 等待后端启动
echo "等待后端服务启动..."
sleep 10

# 启动前端
echo "启动前端服务..."
cd frontend
npm install
npm run dev &
FRONTEND_PID=$!
cd ..

echo "======================================"
echo "服务启动完成!"
echo "后端服务: http://localhost:8080"
echo "前端服务: http://localhost:5173"
echo "======================================"
echo "按 Ctrl+C 停止所有服务"

# 等待用户中断
wait

