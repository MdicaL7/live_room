<template>
  <div class="home">
    <!-- 顶部导航栏 -->
    <header class="navbar">
      <div class="navbar-logo"> <img src="/logo.png" alt="logo" /> </div>
      <nav class="navbar-menu">
        <a class="active">首页</a>
        <a>我的学习</a>
        <a>我的课程</a>
        <a>模考系统</a>
      </nav>
      <div class="navbar-right">
        <el-input placeholder="搜索" size="small" class="search-box"/>
        <span class="user-menu">学习记录 | 我的订阅</span>
        <el-button type="primary" size="small">登录</el-button>
      </div>
    </header>

    <div class="main-content">
      <!-- 主内容区（左） -->
      <main class="main-left">
        <!-- 直播间信息卡片：只展示一条数据 -->
        <div class="liveRoom-card" v-if="liveRoom">
          <img class="liveRoom-cover" :src="liveRoom.cover" alt="cover" />
          <div class="liveRoom-info">
            <span class="live-tag">直播</span>
            <span class="liveRoom-title">{{ liveRoom.title }}</span>
            <span class="liveRoom-time">直播时间：{{ formatTime(liveRoom.created_at) }}</span>
            <el-button type="success" size="small" @click="gotoLiveRoom">
              进入回看
            </el-button>
            <span class="live-status">
              {{ liveRoom.status === 2 ? "直播已结束" : "直播中" }}
            </span>
          </div>
        </div>
        <!-- Tab 区 -->
        <el-tabs class="detail-tabs">
          <el-tab-pane label="详情">
            <div class="empty-box">
              <img src="/empty-box.png" style="width:120px;" />
              <div>暂无简介</div>
            </div>
          </el-tab-pane>
          <el-tab-pane label="课堂互动">
            <!-- 互动内容 -->
          </el-tab-pane>
        </el-tabs>
      </main>
      <!-- 右侧栏 -->
      <aside class="main-right">
        <div class="teacher-card">
          <img class="teacher-avatar" src="/teacher-demo.png" />
          <div class="teacher-name">现网蓝悦2号【7978勿动】</div>
          <el-button type="info" size="small">进店逛逛</el-button>
        </div>
        <div class="recommend-list">
          <div class="recommend-title">相关推荐</div>
          <div class="recommend-item" v-for="item in 3" :key="item">
            <img class="recommend-cover" src="/liveRoom-demo.png" />
            <div class="recommend-info">
              <div class="recommend-name">常常常常测测测测测测...</div>
              <span class="recommend-price">免费</span>
            </div>
          </div>
        </div>
      </aside>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getLiveRoomDetail } from '@/api/liveRoom'

const liveRoom = ref(null)
const router = useRouter()

// 首页暂时只展示id=7这一个直播间
onMounted(async () => {
  const res = await getLiveRoomDetail(3)
  if (res.data.code === 0) {
    liveRoom.value = res.data.data
  }
  // liveRoom.value = {
  //   id: 7,
  //   title: '测试课程',
  //   cover: '/cover-demo.png',
  //   created_at: '2024-06-07T11:00:00',
  //   status: 2
  // }
})

function gotoLiveRoom() {
  // 跳转到详情页（/liveRoom/7）
  router.push(`/liveRoom/${liveRoom.value.id}`)
}

// 时间格式化
function formatTime(time) {
  if (!time) return ''
  return time.replace('T', ' ').replace('+08:00', '')
}
</script>

<style scoped>
.home {
  background: #fafbfc;
  min-height: 100vh;
}
.navbar {
  display: flex;
  align-items: center;
  height: 60px;
  background: #fff;
  border-bottom: 1px solid #f2f3f5;
  padding: 0 40px;
}
.navbar-logo img {
  width: 36px;
}
.navbar-menu {
  flex: 1;
  display: flex;
  gap: 32px;
  margin-left: 24px;
}
.navbar-menu a {
  color: #333;
  font-size: 16px;
  text-decoration: none;
  line-height: 60px;
}
.navbar-menu .active {
  color: #10b98a;
  font-weight: bold;
  border-bottom: 2px solid #10b98a;
}
.navbar-right {
  display: flex;
  align-items: center;
  gap: 18px;
}
.search-box {
  width: 160px;
}
.user-menu {
  font-size: 13px;
  color: #666;
}
.main-content {
  display: flex;
  width: 100%;
  max-width: 1240px;
  margin: 28px auto 0 auto;
  gap: 32px;
}
.main-left {
  flex: 1 1 0;
}
.liveRoom-card {
  display: flex;
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 2px 8px #f4f4f4;
  padding: 20px;
  margin-bottom: 20px;
  align-items: center;
  gap: 28px;
}
.liveRoom-cover {
  width: 180px;
  height: 120px;
  border-radius: 8px;
  background: #e6f6fb;
}
.liveRoom-info {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.live-tag {
  display: inline-block;
  background: #10b98a;
  color: #fff;
  font-size: 13px;
  border-radius: 4px;
  padding: 2px 8px;
  margin-bottom: 2px;
  width: 36px;
  text-align: center;
}
.liveRoom-title {
  font-size: 21px;
  font-weight: bold;
  margin-bottom: 6px;
}
.liveRoom-time {
  color: #666;
  font-size: 13px;
}
.live-status {
  color: #999;
  font-size: 13px;
}
.detail-tabs {
  margin-top: 18px;
  background: #fff;
  border-radius: 10px;
  padding: 18px;
  min-height: 260px;
}
.empty-box {
  display: flex;
  flex-direction: column;
  align-items: center;
  color: #888;
  font-size: 15px;
  margin: 42px 0;
}
.main-right {
  width: 260px;
  display: flex;
  flex-direction: column;
  gap: 28px;
}
.teacher-card {
  background: #fff;
  border-radius: 10px;
  text-align: center;
  padding: 28px 0 16px 0;
  box-shadow: 0 2px 8px #f4f4f4;
  margin-bottom: 18px;
}
.teacher-avatar {
  width: 64px;
  height: 64px;
  border-radius: 50%;
  margin-bottom: 10px;
}
.teacher-name {
  font-size: 15px;
  color: #333;
  margin-bottom: 8px;
}
.recommend-list {
  background: #fff;
  border-radius: 10px;
  padding: 18px 14px;
}
.recommend-title {
  font-size: 16px;
  color: #222;
  font-weight: bold;
  margin-bottom: 12px;
}
.recommend-item {
  display: flex;
  align-items: center;
  gap: 10px;
  padding: 7px 0;
  border-bottom: 1px solid #f0f0f0;
}
.recommend-item:last-child {
  border-bottom: none;
}
.recommend-cover {
  width: 42px;
  height: 42px;
  border-radius: 5px;
  background: #e6f6fb;
}
.recommend-info {
  flex: 1;
  display: flex;
  flex-direction: column;
}
.recommend-name {
  font-size: 13px;
  color: #333;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  margin-bottom: 2px;
}
.recommend-price {
  color: #10b98a;
  font-size: 12px;
}
</style>