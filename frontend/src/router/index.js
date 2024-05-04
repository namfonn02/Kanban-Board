import { createRouter, createWebHistory } from 'vue-router'
// import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: '/task'
    },
    {
      path: '/task',
      name: 'tasks',
      component: () => import('../views/HomeView.vue'),
      children: [
        {
          path: ':id',
          name: 'task-modaldetail',
          component: () => import('../views/TaskDetail.vue')
        },
        {
          path: 'add',
          name: 'task-addmodal', // Changed the name to 'task-addmodal'
          component: () => import('../components/AddTask.vue')
        }
      ]
    }
  ]
})

export default router
