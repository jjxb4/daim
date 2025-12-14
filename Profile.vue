<template>
  <div class="profile-container">
    <h2>个人资料</h2>

    <el-card>
      <el-form :model="profileForm" :rules="profileRules" ref="profileFormRef" label-width="100px">
        <el-form-item label="姓名" prop="username">
          <el-input v-model="profileForm.username" />
        </el-form-item>
        <el-form-item label="邮箱" prop="email">
          <el-input v-model="profileForm.email" />
        </el-form-item>
        <el-form-item label="头像URL" prop="avatar">
          <el-input v-model="profileForm.avatar" />
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="handleUpdate">保存修改</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage } from 'element-plus'
import { getEmployeeProfile, updateEmployeeProfile } from '@/api/employee'

const profileFormRef = ref(null)

const profileForm = ref({
  username: '',
  email: '',
  avatar: ''
})

const profileRules = {
  username: [{ required: true, message: '请输入姓名', trigger: 'blur' }],
  email: [
    { required: true, message: '请输入邮箱', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱格式', trigger: 'blur' }
  ]
}

const loadProfile = async () => {
  const res = await getEmployeeProfile()
  profileForm.value = {
    username: res.data.username,
    email: res.data.email,
    avatar: res.data.avatar || ''
  }
}

const handleUpdate = async () => {
  await profileFormRef.value.validate()
  try {
    await updateEmployeeProfile(profileForm.value)
    ElMessage.success('修改成功')
  } catch (error) {
    ElMessage.error(error.message || '修改失败')
  }
}

onMounted(() => {
  loadProfile()
})
</script>

<style scoped>
.profile-container {
  max-width: 800px;
  margin: 0 auto;
}

h2 {
  margin-bottom: 30px;
  color: #333;
}
</style>

