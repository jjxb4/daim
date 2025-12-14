<template>
  <div class="home-container">
    <el-carousel height="300px" class="banner">
      <el-carousel-item>
        <div class="banner-item">
          <h1>专业家政服务</h1>
          <p>为您提供优质的家政服务体验</p>
        </div>
      </el-carousel-item>
    </el-carousel>

    <div class="hot-services">
      <h2>热门服务</h2>
      <el-row :gutter="20">
        <el-col :span="8" v-for="service in services" :key="service.id">
          <el-card class="service-card" shadow="hover">
            <img :src="service.imageUrl || 'https://via.placeholder.com/300x200'" class="service-image" />
            <div class="service-info">
              <h3>{{ service.name }}</h3>
              <p class="price">¥{{ service.price }}</p>
              <el-button type="primary" @click="viewDetail(service.id)">查看详情</el-button>
            </div>
          </el-card>
        </el-col>
      </el-row>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getHotServices } from '@/api/service'

const router = useRouter()
const services = ref([])

const loadServices = async () => {
  const res = await getHotServices()
  services.value = res.data
}

const viewDetail = (id) => {
  router.push(`/user/service/${id}`)
}

onMounted(() => {
  loadServices()
})
</script>

<style scoped>
.home-container {
  max-width: 1200px;
  margin: 0 auto;
}

.banner {
  margin-bottom: 40px;
  border-radius: 8px;
  overflow: hidden;
}

.banner-item {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
}

.banner-item h1 {
  font-size: 48px;
  margin-bottom: 20px;
}

.hot-services h2 {
  margin-bottom: 30px;
  color: #333;
}

.service-card {
  margin-bottom: 20px;
}

.service-image {
  width: 100%;
  height: 200px;
  object-fit: cover;
}

.service-info {
  padding: 15px 0;
}

.service-info h3 {
  margin-bottom: 10px;
  color: #333;
}

.price {
  color: #f56c6c;
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 15px;
}
</style>

