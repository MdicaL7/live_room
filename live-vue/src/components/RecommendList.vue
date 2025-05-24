<template>
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
</template>
<script setup></script>
<style scoped>
/* 复制 .recommend-list, .recommend-title, .recommend-item, .recommend-cover, .recommend-info, .recommend-name, .recommend-price 样式 */
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