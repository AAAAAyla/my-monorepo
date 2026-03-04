import axios from 'axios'

// 先用本地后端地址测试（确保后端也在运行）
const API = 'http://localhost:3000/api'

export const getPosts = () => axios.get(`${API}/posts`)
export const createPost = (data: any) => axios.post(`${API}/posts`, data)
export const updatePost = (id: string, data: any) => axios.put(`${API}/posts/${id}`, data)
export const deletePost = (id: string) => axios.delete(`${API}/posts/${id}`)