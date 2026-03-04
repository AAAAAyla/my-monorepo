import Koa from 'koa'
import bodyParser from 'koa-bodyparser'
import serve from 'koa-static'
import { fileURLToPath } from 'url'  // ← 新增
import { dirname, join } from 'path'  // ← 修改
import demoRouter from './routes/demo.js'
import postsRouter from './routes/posts.js'

// ES Module 兼容 __dirname
const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

const app = new Koa()
app.use(bodyParser())

// API 路由
app.use(demoRouter.routes()).use(demoRouter.allowedMethods())
app.use(postsRouter.routes()).use(postsRouter.allowedMethods())

// 托管前端静态文件
app.use(serve(join(__dirname, '../public')))

const PORT = 3000
app.listen(PORT, () => console.log(`API ready at http://localhost:${PORT}`))