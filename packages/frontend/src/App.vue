<template>
  <div style="max-width: 800px; margin: 0 auto; padding: 20px;">
    <h1>📝 我的博客</h1>

    <!-- 文章列表 -->
    <h2>文章列表</h2>
    <div v-if="posts.length === 0">暂无文章</div>
    <div v-for="post in posts" :key="post._id" style="border:1px solid #ccc; margin-bottom:10px; padding:10px; border-radius:5px;">
      <h3>{{ post.title }}</h3>
      <p>{{ post.content }}</p>
      <small>作者：{{ post.author }} | 发布时间：{{ new Date(post.createdAt).toLocaleString() }}</small>
    </div>

    <!-- 新增文章表单 -->
    <h2>✍️ 写新文章</h2>
    <form @submit.prevent="submitPost">
      <div>
        <label>标题：</label><br>
        <input v-model="newPost.title" required style="width:100%; padding:8px; margin-bottom:10px;">
      </div>
      <div>
        <label>内容：</label><br>
        <textarea v-model="newPost.content" required rows="4" style="width:100%; padding:8px; margin-bottom:10px;"></textarea>
      </div>
      <div>
        <label>作者：</label><br>
        <input v-model="newPost.author" required style="width:100%; padding:8px; margin-bottom:10px;">
      </div>
      <button type="submit" style="padding:10px 20px; background:#42b983; color:white; border:none; border-radius:5px; cursor:pointer;">发布文章</button>
    </form>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { getPosts, createPost, type Post } from './api/posts'  // 引入类型

const posts = ref<Post[]>([])  // 指定泛型

const newPost = ref({
  title: '',
  content: '',
  author: 'admin'
})

const fetchPosts = async () => {
  try {
    const res = await getPosts()
    posts.value = res.data.data  // res.data 是 { data: Post[] }
  } catch (err) {
    console.error('获取文章失败', err)
  }
}

const submitPost = async () => {
  try {
    await createPost(newPost.value)
    newPost.value = { title: '', content: '', author: 'admin' }
    await fetchPosts()
  } catch (err) {
    console.error('发布失败', err)
  }
}

onMounted(() => {
  fetchPosts()
})
</script>

<style scoped>
/* 简单的样式，可自行调整 */
input, textarea {
  border: 1px solid #ddd;
  border-radius: 4px;
}
button:hover {
  background: #369f6e;
}
</style>