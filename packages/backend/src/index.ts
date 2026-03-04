import Koa from 'koa'
import bodyParser from 'koa-bodyparser'
import serve from 'koa-static'           // ← 新增
import path from 'path'                   // ← 新增
import demoRouter from './routes/demo.js'
import postsRouter from './routes/posts.js'

const app = new Koa()

// 1. API 路由
app.use(bodyParser())
app.use(demoRouter.routes()).use(demoRouter.allowedMethods())
app.use(postsRouter.routes()).use(postsRouter.allowedMethods())

// 2. 托管前端静态文件（关键！）
// 开发时前端跑在 5173，生产时 dist 文件夹挂到后端
app.use(serve(path.join(__dirname, '../public')))

// 3. 兜底：所有路由都返回 index.html（Vue Router 需要）
app.use(async (ctx, next) => {
  if (ctx.path.startsWith('/api')) return next()
  ctx.type = 'html'
  ctx.body = require('fs').readFileSync(path.join(__dirname, '../public/index.html'))
})

const PORT = 3000
app.listen(PORT, () => console.log(`Server ready at http://localhost:${PORT}`))