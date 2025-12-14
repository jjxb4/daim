<template>
  <div class="service-detail-container">
    <el-card v-if="service">
      <el-row :gutter="40">
        <el-col :span="12">
          <img :src="service.imageUrl || 'https://via.placeholder.com/500x400'" class="service-image" />
        </el-col>
        <el-col :span="12">
          <h2>{{ service.name }}</h2>
          <p class="category">类型: {{ service.category }}</p>
          <p class="price">¥{{ service.price }}</p>
          <el-button type="primary" size="large" @click="showBookingDialog">立即预约</el-button>
          <div class="description">
            <h3>服务简介</h3>
            <p>{{ service.description || '暂无描述' }}</p>
          </div>
        </el-col>
      </el-row>
    </el-card>

    <el-card class="reviews-section" v-if="reviews.length > 0">
      <h3>用户评价</h3>
      <div v-for="review in reviews" :key="review.id" class="review-item">
        <el-rate v-model="review.rating" disabled />
        <p class="review-content">{{ review.content }}</p>
        <p class="review-date">{{ formatDate(review.createdAt) }}</p>
      </div>
    </el-card>

    <el-dialog v-model="bookingDialogVisible" title="预约服务" width="500px">
      <el-form :model="bookingForm" :rules="bookingRules" ref="bookingFormRef">
        <el-form-item label="预约时间" prop="appointmentTime">
          <el-date-picker
            v-model="bookingForm.appointmentTime"
            type="datetime"
            placeholder="选择预约时间"
            style="width: 100%"
          />
        </el-form-item>
        <el-form-item label="服务地址" prop="address">
          <el-input v-model="bookingForm.address" placeholder="请输入服务地址" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="bookingForm.remarks" type="textarea" placeholder="其他需求说明" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="bookingDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleBooking">确认预约</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import { getServiceById, getServiceReviews } from '@/api/service'
import { createOrder } from '@/api/order'

const route = useRoute()
const router = useRouter()
const service = ref(null)
const reviews = ref([])
const bookingDialogVisible = ref(false)
const bookingFormRef = ref(null)

const bookingForm = ref({
  appointmentTime: '',
  address: '',
  remarks: ''
})

const bookingRules = {
  appointmentTime: [{ required: true, message: '请选择预约时间', trigger: 'change' }],
  address: [{ required: true, message: '请输入服务地址', trigger: 'blur' }]
}

const loadService = async () => {
  const res = await getServiceById(route.params.id)
  service.value = res.data
}

const loadReviews = async () => {
  const res = await getServiceReviews(route.params.id)
  reviews.value = res.data
}

const showBookingDialog = () => {
  bookingDialogVisible.value = true
}

const handleBooking = async () => {
  await bookingFormRef.value.validate()
  try {
    await createOrder({
      serviceId: service.value.id,
      amount: service.value.price,
      appointmentTime: bookingForm.value.appointmentTime,
      address: bookingForm.value.address,
      remarks: bookingForm.value.remarks
    })
    ElMessage.success('预约成功')
    bookingDialogVisible.value = false
    router.push('/user/orders')
  } catch (error) {
    ElMessage.error(error.message || '预约失败')
  }
}

const formatDate = (date) => {
  return new Date(date).toLocaleString('zh-CN')
}

onMounted(() => {
  loadService()
  loadReviews()
})
</script>

<style scoped>
.service-detail-container {
  max-width: 1200px;
  margin: 0 auto;
}

.service-image {
  width: 100%;
  height: 400px;
  object-fit: cover;
  border-radius: 8px;
}

h2 {
  margin-bottom: 15px;
  color: #333;
}

.category {
  color: #999;
  margin-bottom: 10px;
}

.price {
  color: #f56c6c;
  font-size: 32px;
  font-weight: bold;
  margin: 20px 0;
}

.description {
  margin-top: 40px;
}

.description h3 {
  margin-bottom: 15px;
  color: #333;
}

.description p {
  line-height: 1.8;
  color: #666;
}

.reviews-section {
  margin-top: 30px;
}

.reviews-section h3 {
  margin-bottom: 20px;
  color: #333;
}

.review-item {
  padding: 15px 0;
  border-bottom: 1px solid #eee;
}

.review-item:last-child {
  border-bottom: none;
}

.review-content {
  margin: 10px 0;
  color: #666;
}

.review-date {
  color: #999;
  font-size: 12px;
}
</style>

