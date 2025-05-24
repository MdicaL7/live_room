<template>
  <div class="live-room-wrap">
    <!-- 左侧视频播放区 -->
    <div class="video-area">
      <video
        class="video-player"
        controls
        :src="liveRoom?.replay_url"
        poster="/cover-demo.png"
      ></video>
    </div>

    <!-- 右侧互动区 -->
    <div class="side-panel">
      <el-tabs v-model="activeTab">
        <el-tab-pane label="讲解" name="explain">
          <div class="system-tip">
            系统提示：直播内容及互动评论严禁传播违法或不实信息，如有违规，均将依法采取封禁措施。严禁未成年人直播打赏。请谨慎判断，注意财产安全，以防人身或财产损失。
          </div>
          <div class="user-row">
            <img class="avatar" src="/anchor-demo.png" />
            <span class="username">直播助手</span>
          </div>
          <el-card class="welcome-box">
            <div style="color:#3698f7;">欢迎进入直播间：</div>
            <div style="font-size:14px;">
              1. 请自行调节手机音量至合适的状态。<br />
              2. 直播界面显示讲师发布的内容，听众可在讨论区进行交流或弹幕形式查看。<br />
              3. 直播结束后，你可以随时回看全部内容。
            </div>
          </el-card>
        </el-tab-pane>
        <el-tab-pane label="讨论" name="discuss">
          <div class="chat-list">
            <div class="chat-msg" v-for="(msg, idx) in messages" :key="idx">
              <span class="msg-user">{{ msg.user }}</span>：<span>{{ msg.content }}</span>
            </div>
          </div>
        </el-tab-pane>
        <el-tab-pane label="文件" name="files">
          <div style="color:#888;">暂无文件</div>
        </el-tab-pane>
      </el-tabs>

      <!-- 聊天输入区 -->
      <div class="chat-input-area">
        <el-input
          v-model="inputMsg"
          placeholder="请输入您的讨论内容"
          size="small"
          @keyup.enter="sendMsg"
        ></el-input>
        <el-button
          type="success"
          size="small"
          style="margin-left: 8px"
          @click="sendMsg"
        >发送</el-button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { getLiveRoomDetail } from '@/api/liveRoom'

const route = useRoute()
const liveRoom = ref(null)
const activeTab = ref('explain')

// 简单模拟消息
const messages = ref([
  { user: '直播助手', content: '欢迎大家进入直播间！' },
  { user: '小明', content: '老师讲得很好！' }
])
const inputMsg = ref('')

onMounted(async () => {
  // 动态获取课程回放数据
  const res = await getLiveRoomDetail(route.params.id)
  if (res.data.code === 0) {
    liveRoom.value = res.data.data
  }
})

function sendMsg() {
  if (inputMsg.value.trim() !== '') {
    messages.value.push({ user: '我', content: inputMsg.value })
    inputMsg.value = ''
  }
}
</script>

<style scoped>
.live-room-wrap {
  display: flex;
  height: 100vh;
  background: #f8f9fb;
}
.video-area {
  flex: 1 1 0;
  display: flex;
  justify-content: center;
  align-items: center;
  background: #222;
}
.video-player {
  width: 96%;
  max-width: 900px;
  min-height: 400px;
  background: #000;
  border-radius: 10px;
  margin: 24px 0;
}
.side-panel {
  width: 400px;
  min-width: 340px;
  background: #fff;
  box-shadow: -2px 0 16px #ececec;
  display: flex;
  flex-direction: column;
  padding: 24px 16px 8px 16px;
}
.system-tip {
  color: #888;
  background: #f6f6f8;
  font-size: 13px;
  padding: 8px 12px;
  margin-bottom: 10px;
  border-radius: 5px;
}
.user-row {
  display: flex;
  align-items: center;
  margin-bottom: 10px;
}
.avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
  margin-right: 8px;
  background: #e6f0f9;
}
.username {
  font-weight: bold;
  font-size: 15px;
  color: #333;
}
.welcome-box {
  margin: 8px 0 16px 0;
}
.chat-list {
  min-height: 140px;
  max-height: 220px;
  overflow-y: auto;
  margin-bottom: 12px;
}
.chat-msg {
  margin-bottom: 7px;
  font-size: 14px;
}
.msg-user {
  color: #1989fa;
  font-weight: bold;
}
.chat-input-area {
  display: flex;
  align-items: center;
  margin-top: 12px;
  background: #f6f6f8;
  padding: 8px 12px;
  border-radius: 8px;
}
</style>