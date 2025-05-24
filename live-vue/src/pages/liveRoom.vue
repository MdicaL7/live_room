<template>
  <div class="live-room-wrap"
       v-if="liveRoom">
    <!-- 左侧视频播放区 -->
    <div class="video-area">
      <video class="video-player"
             controls
             :src="liveRoom?.replay_url"
             poster="/cover-demo.png"></video>
    </div>

    <!-- 右侧互动区 -->
    <div class="side-panel">
      <el-tabs v-model="activeTab">
        <el-tab-pane label="讲解"
                     name="explain">
          <div class="system-tip">
            系统提示：直播内容及互动评论严禁传播违法或不实信息，如有违规，均将依法采取封禁措施。严禁未成年人直播打赏。请谨慎判断，注意财产安全，以防人身或财产损失。
          </div>
          <div class="user-row">
            <img class="avatar"
                 src="/anchor-demo.png" />
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
        <el-tab-pane label="讨论"
                     name="discuss">
          <div class="chat-list">
            <div class="chat-msg"
                 v-for="(msg, idx) in messages"
                 :key="idx"
                 :class="{ 'my-msg': msg.user === username }">
              <span class="msg-user">{{ msg.user }}</span>
              <span class="msg-content">{{ msg.content }}</span>
            </div>
          </div>
        </el-tab-pane>
        <el-tab-pane label="文件"
                     name="files">
          <div style="color:#888;">暂无文件</div>
        </el-tab-pane>
      </el-tabs>

      <!-- 聊天输入区 -->
      <div class="chat-input-area">
        <el-input v-model="inputMsg"
                  placeholder="请输入您的讨论内容"
                  size="small"
                  @keyup.enter="sendMsg"></el-input>
        <el-button type="success"
                   size="small"
                   style="margin-left: 8px"
                   @click="sendMsg">发送</el-button>
      </div>
    </div>
  </div>
  <div v-else
       class="loading-wrap">加载中...</div>
</template>

<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'
import { useRoute } from 'vue-router'
import { getLiveRoomDetail } from '@/api/liveRoom'

const route = useRoute()
const liveRoom = ref(null)
const activeTab = ref('explain')
const messages = ref([{ user: '直播助手', content: '欢迎大家进入直播间！' }])
const inputMsg = ref('')
const username = sessionStorage.getItem('username')
let socket = null

onMounted(async () => {
  // 获取直播间数据
  const res = await getLiveRoomDetail(route.params.id)
  if (res.data.code === 200) {
    liveRoom.value = res.data.data
    sessionStorage.setItem('roomID', liveRoom.value.id)

    // 只有获取到roomID后再建立WebSocket连接
    socket = new WebSocket(`ws://localhost:8080/v1/api/ws/${liveRoom.value.id}`)
    socket.onmessage = (event) => {
      const msg = JSON.parse(event.data)
      messages.value.push(msg)
    }
    socket.onerror = (err) => {
      console.error('WebSocket error:', err)
    }
  }
})

function sendMsg() {
  if (!inputMsg.value.trim()) return
  if (!socket || socket.readyState !== 1) {
    alert('WebSocket 正在连接，请稍后再试')
    return
  }
  socket.send(
    JSON.stringify({
      user: username,
      content: inputMsg.value,
    })
  )
  inputMsg.value = ''
}

onBeforeUnmount(() => {
  if (socket) socket.close()
})
</script>

<style scoped>
.live-room-wrap {
  display: flex;
  height: 100vh;
  background: #f8f9fb;
}
.video-area {
  flex: 1 1 0;
  /* 去掉居中 */
  display: flex;
  /* justify-content: center;
  align-items: center; */
  background: #222;
  /* 新增 */
  position: relative;
  height: 100vh;
  min-width: 0;
  min-height: 0;
}

.video-player {
  width: 100%;
  height: 100%;
  background: #000;
  border-radius: 0; /* 取消圆角防止出现黑角 */
  margin: 0; /* 取消外边距 */
  display: block;
  object-fit: cover; /* 铺满区域，可能会裁切部分画面 */
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
  display: flex;
  align-items: center; /* 让内容和用户名垂直居中 */
  justify-content: flex-start;
}
.my-msg {
  justify-content: flex-end;
}
.msg-user {
  color: #1989fa;
  font-weight: bold;
  margin-right: 8px;
  height: 32px;
  display: flex;
  align-items: center;
}
.my-msg .msg-user {
  color: #00b578;
}
.msg-content {
  background: #f6f6f8;
  border-radius: 16px;
  padding: 6px 14px;
  display: flex;
  align-items: center;
  font-size: 16px;
  min-height: 32px;
}
.my-msg .msg-content {
  background: #e8f8f2;
  color: #333;
}
.chat-input-area {
  display: flex;
  align-items: center;
  margin-top: 12px;
  background: #f6f6f8;
  padding: 8px 12px;
  border-radius: 8px;
}
.loading-wrap {
  min-height: 400px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
  font-size: 18px;
}
</style>