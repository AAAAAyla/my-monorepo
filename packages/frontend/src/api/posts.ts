import axios from 'axios'

// 定义文章数据类型
export interface Post {
  _id: string
  title: string
  content: string
  author: string
  createdAt: string
  updatedAt?: string
}

// 根据环境切换 API 地址（开发用 localhost，生产用阿里云 IP）
const API = import.meta.env.DEV 
  ? 'http://localhost:3000/api' 
  : 'http://47.83.206.196/api'

// 为每个请求添加类型，明确返回的数据结构
export const getPosts = () => axios.get<{ data: Post[] }>(`${API}/posts`)
export const createPost = (data: { title: string; content: string; author: string }) => 
  axios.post<{ data: Post }>(`${API}/posts`, data)
export const updatePost = (id: string, data: any) => axios.put(`${API}/posts/${id}`, data)
export const deletePost = (id: string) => axios.delete(`${API}/posts/${id}`)