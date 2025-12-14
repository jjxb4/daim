<template>
  <div class="services-container">
    <h2>服务管理</h2>

    <el-button type="primary" @click="showAddDialog" style="margin-bottom: 20px">添加服务</el-button>

    <el-table :data="services" border>
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="name" label="服务名称" width="200" />
      <el-table-column prop="category" label="类别" width="150" />
      <el-table-column prop="price" label="价格" width="100">
        <template #default="{ row }">
          ¥{{ row.price }}
        </template>
      </el-table-column>
      <el-table-column prop="status" label="状态" width="100">
        <template #default="{ row }">
          <el-tag :type="row.status === 'active' ? 'success' : 'info'">
            {{ row.status === 'active' ? '可用' : '不可用' }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="description" label="描述" />
      <el-table-column label="操作" width="250">
        <template #default="{ row }">
          <el-button size="small" @click="showEditDialog(row)">编辑</el-button>
          <el-button size="small" type="danger" @click="handleDelete(row.id)">删除</el-button>
          <el-button size="small" :type="row.status === 'active' ? 'warning' : 'success'" @click="toggleStatus(row)">
            {{ row.status === 'active' ? '禁用' : '启用' }}
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      v-model:current-page="page"
      :page-size="pageSize"
      :total="total"
      @current-change="loadServices"
      layout="total, prev, pager, next"
      style="margin-top: 20px; text-align: center"
    />

    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="600px">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="100px">
        <el-form-item label="服务名称" prop="name">
          <el-input v-model="form.name" />
        </el-form-item>
        <el-form-item label="类别" prop="category">
          <el-select v-model="form.category" style="width: 100%">
            <el-option label="保洁服务" value="保洁服务" />
            <el-option label="保姆服务" value="保姆服务" />
            <el-option label="月嫂服务" value="月嫂服务" />
            <el-option label="家庭护理服务" value="家庭护理服务" />
          </el-select>
        </el-form-item>
        <el-form-item label="价格" prop="price">
          <el-input-number v-model="form.price" :min="0" :precision="2" style="width: 100%" />
        </el-form-item>
        <el-form-item label="图片URL" prop="imageUrl">
          <el-input v-model="form.imageUrl" />
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input v-model="form.description" type="textarea" rows="4" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" style="width: 100%">
            <el-option label="可用" value="active" />
            <el-option label="不可用" value="inactive" />
          </el-select>
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit">确定</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getAdminServices, addService, updateService, deleteService, updateServiceStatus } from '@/api/admin'

const services = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const dialogVisible = ref(false)
const dialogTitle = ref('')
const isEdit = ref(false)
const formRef = ref(null)

const form = ref({
  id: null,
  name: '',
  category: '',
  price: 0,
  imageUrl: '',
  description: '',
  status: 'active'
})

const rules = {
  name: [{ required: true, message: '请输入服务名称', trigger: 'blur' }],
  category: [{ required: true, message: '请选择类别', trigger: 'change' }],
  price: [{ required: true, message: '请输入价格', trigger: 'blur' }],
  status: [{ required: true, message: '请选择状态', trigger: 'change' }]
}

const loadServices = async () => {
  const res = await getAdminServices({ page: page.value, size: pageSize.value })
  services.value = res.data.list
  total.value = res.data.total
}

const showAddDialog = () => {
  isEdit.value = false
  dialogTitle.value = '添加服务'
  form.value = {
    id: null,
    name: '',
    category: '',
    price: 0,
    imageUrl: '',
    description: '',
    status: 'active'
  }
  dialogVisible.value = true
}

const showEditDialog = (row) => {
  isEdit.value = true
  dialogTitle.value = '编辑服务'
  form.value = {
    id: row.id,
    name: row.name,
    category: row.category,
    price: row.price,
    imageUrl: row.imageUrl,
    description: row.description,
    status: row.status
  }
  dialogVisible.value = true
}

const handleSubmit = async () => {
  await formRef.value.validate()
  try {
    if (isEdit.value) {
      await updateService(form.value.id, form.value)
      ElMessage.success('修改成功')
    } else {
      await addService(form.value)
      ElMessage.success('添加成功')
    }
    dialogVisible.value = false
    loadServices()
  } catch (error) {
    ElMessage.error(error.message || '操作失败')
  }
}

const handleDelete = async (id) => {
  try {
    await ElMessageBox.confirm('确认删除该服务?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await deleteService(id)
    ElMessage.success('删除成功')
    loadServices()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(error.message || '删除失败')
    }
  }
}

const toggleStatus = async (row) => {
  try {
    const newStatus = row.status === 'active' ? 'inactive' : 'active'
    await updateServiceStatus(row.id, newStatus)
    ElMessage.success('状态修改成功')
    loadServices()
  } catch (error) {
    ElMessage.error(error.message || '操作失败')
  }
}

onMounted(() => {
  loadServices()
})
</script>

<style scoped>
.services-container {
  max-width: 1400px;
  margin: 0 auto;
}

h2 {
  margin-bottom: 30px;
  color: #333;
}
</style>

