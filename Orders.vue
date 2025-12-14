<template>
  <div class="orders-container">
    <h2>订单管理</h2>

    <el-table :data="orders" border>
      <el-table-column prop="orderNo" label="订单号" width="180" />
      <el-table-column prop="userId" label="客户ID" width="100" />
      <el-table-column prop="serviceId" label="服务ID" width="100" />
      <el-table-column prop="amount" label="金额" width="100">
        <template #default="{ row }">
          ¥{{ row.amount }}
        </template>
      </el-table-column>
      <el-table-column prop="createdAt" label="下单时间" width="180">
        <template #default="{ row }">
          {{ formatDate(row.createdAt) }}
        </template>
      </el-table-column>
      <el-table-column prop="status" label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="getStatusType(row.status)">{{ getStatusText(row.status) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200">
        <template #default="{ row }">
          <el-button size="small" @click="showStatusDialog(row)">修改状态</el-button>
          <el-button size="small" type="danger" @click="handleDelete(row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      v-model:current-page="page"
      :page-size="pageSize"
      :total="total"
      @current-change="loadOrders"
      layout="total, prev, pager, next"
      style="margin-top: 20px; text-align: center"
    />

    <el-dialog v-model="statusDialogVisible" title="修改订单状态" width="400px">
      <el-select v-model="selectedStatus" placeholder="选择状态" style="width: 100%">
        <el-option label="待确认" value="pending" />
        <el-option label="已确认" value="confirmed" />
        <el-option label="进行中" value="in_progress" />
        <el-option label="已完成" value="completed" />
        <el-option label="已取消" value="cancelled" />
      </el-select>
      <template #footer>
        <el-button @click="statusDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleUpdateStatus">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getAdminOrders, updateOrderStatus, deleteOrder } from '@/api/admin'

const orders = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const statusDialogVisible = ref(false)
const selectedStatus = ref('')
const currentOrderId = ref(null)

const loadOrders = async () => {
  const res = await getAdminOrders({ page: page.value, size: pageSize.value })
  orders.value = res.data.list
  total.value = res.data.total
}

const showStatusDialog = (row) => {
  currentOrderId.value = row.id
  selectedStatus.value = row.status
  statusDialogVisible.value = true
}

const handleUpdateStatus = async () => {
  try {
    await updateOrderStatus(currentOrderId.value, selectedStatus.value)
    ElMessage.success('状态修改成功')
    statusDialogVisible.value = false
    loadOrders()
  } catch (error) {
    ElMessage.error(error.message || '修改失败')
  }
}

const handleDelete = async (id) => {
  try {
    await ElMessageBox.confirm('确认删除该订单?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await deleteOrder(id)
    ElMessage.success('删除成功')
    loadOrders()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(error.message || '删除失败')
    }
  }
}

const formatDate = (date) => {
  return new Date(date).toLocaleString('zh-CN')
}

const getStatusType = (status) => {
  const map = {
    pending: 'warning',
    confirmed: 'info',
    in_progress: 'primary',
    completed: 'success',
    cancelled: 'danger'
  }
  return map[status] || 'info'
}

const getStatusText = (status) => {
  const map = {
    pending: '待确认',
    confirmed: '已确认',
    in_progress: '进行中',
    completed: '已完成',
    cancelled: '已取消'
  }
  return map[status] || status
}

onMounted(() => {
  loadOrders()
})
</script>

<style scoped>
.orders-container {
  max-width: 1400px;
  margin: 0 auto;
}

h2 {
  margin-bottom: 30px;
  color: #333;
}
</style>

