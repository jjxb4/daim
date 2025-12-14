<template>
  <div class="announcements-container">
    <h2>公告管理</h2>

    <el-button type="primary" @click="showAddDialog" style="margin-bottom: 20px">发布公告</el-button>

    <el-table :data="announcements" border>
      <el-table-column prop="id" label="ID" width="80" />
      <el-table-column prop="title" label="标题" width="300" />
      <el-table-column prop="createdAt" label="发布时间" width="180">
        <template #default="{ row }">
          {{ formatDate(row.createdAt) }}
        </template>
      </el-table-column>
      <el-table-column prop="status" label="状态" width="100">
        <template #default="{ row }">
          <el-tag v-if="row.status === 'published'" type="success">已发布</el-tag>
          <el-tag v-else-if="row.status === 'draft'" type="info">草稿</el-tag>
          <el-tag v-else type="warning">已归档</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="content" label="内容" />
      <el-table-column label="操作" width="250">
        <template #default="{ row }">
          <el-button size="small" @click="showEditDialog(row)">编辑</el-button>
          <el-button size="small" type="danger" @click="handleDelete(row.id)">删除</el-button>
          <el-button size="small" :type="row.status === 'published' ? 'warning' : 'success'" @click="toggleStatus(row)">
            {{ row.status === 'published' ? '下架' : '发布' }}
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-pagination
      v-model:current-page="page"
      :page-size="pageSize"
      :total="total"
      @current-change="loadAnnouncements"
      layout="total, prev, pager, next"
      style="margin-top: 20px; text-align: center"
    />

    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="600px">
      <el-form :model="form" :rules="rules" ref="formRef" label-width="100px">
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" />
        </el-form-item>
        <el-form-item label="内容" prop="content">
          <el-input v-model="form.content" type="textarea" rows="6" />
        </el-form-item>
        <el-form-item label="状态" prop="status">
          <el-select v-model="form.status" style="width: 100%">
            <el-option label="已发布" value="published" />
            <el-option label="草稿" value="draft" />
            <el-option label="已归档" value="archived" />
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
import { getAdminAnnouncements, addAnnouncement, updateAnnouncement, deleteAnnouncement, updateAnnouncementStatus } from '@/api/admin'

const announcements = ref([])
const page = ref(1)
const pageSize = ref(10)
const total = ref(0)
const dialogVisible = ref(false)
const dialogTitle = ref('')
const isEdit = ref(false)
const formRef = ref(null)

const form = ref({
  id: null,
  title: '',
  content: '',
  status: 'published'
})

const rules = {
  title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
  content: [{ required: true, message: '请输入内容', trigger: 'blur' }],
  status: [{ required: true, message: '请选择状态', trigger: 'change' }]
}

const loadAnnouncements = async () => {
  const res = await getAdminAnnouncements({ page: page.value, size: pageSize.value })
  announcements.value = res.data.list
  total.value = res.data.total
}

const showAddDialog = () => {
  isEdit.value = false
  dialogTitle.value = '发布公告'
  form.value = {
    id: null,
    title: '',
    content: '',
    status: 'published'
  }
  dialogVisible.value = true
}

const showEditDialog = (row) => {
  isEdit.value = true
  dialogTitle.value = '编辑公告'
  form.value = {
    id: row.id,
    title: row.title,
    content: row.content,
    status: row.status
  }
  dialogVisible.value = true
}

const handleSubmit = async () => {
  await formRef.value.validate()
  try {
    if (isEdit.value) {
      await updateAnnouncement(form.value.id, form.value)
      ElMessage.success('修改成功')
    } else {
      await addAnnouncement(form.value)
      ElMessage.success('发布成功')
    }
    dialogVisible.value = false
    loadAnnouncements()
  } catch (error) {
    ElMessage.error(error.message || '操作失败')
  }
}

const handleDelete = async (id) => {
  try {
    await ElMessageBox.confirm('确认删除该公告?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    await deleteAnnouncement(id)
    ElMessage.success('删除成功')
    loadAnnouncements()
  } catch (error) {
    if (error !== 'cancel') {
      ElMessage.error(error.message || '删除失败')
    }
  }
}

const toggleStatus = async (row) => {
  try {
    const newStatus = row.status === 'published' ? 'archived' : 'published'
    await updateAnnouncementStatus(row.id, newStatus)
    ElMessage.success('状态修改成功')
    loadAnnouncements()
  } catch (error) {
    ElMessage.error(error.message || '操作失败')
  }
}

const formatDate = (date) => {
  return new Date(date).toLocaleString('zh-CN')
}

onMounted(() => {
  loadAnnouncements()
})
</script>

<style scoped>
.announcements-container {
  max-width: 1400px;
  margin: 0 auto;
}

h2 {
  margin-bottom: 30px;
  color: #333;
}
</style>

