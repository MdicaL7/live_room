import { createRouter, createWebHistory } from 'vue-router'

// 懒加载页面
const Home = () => import('@/pages/Home.vue')
const Course = () => import('@/pages/Course.vue')

const routes = [
  { path: '/', component: Home },
  { path: '/course/:id', component: Course }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

export default router