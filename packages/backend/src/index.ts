import Koa from 'koa'
import bodyParser from 'koa-bodyparser'
import serve from 'koa-static'
import { fileURLToPath } from 'url'
import { dirname, join } from 'path'
import demoRouter from './routes/demo.js'
import postsRouter from './routes/posts.js'

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

const app = new Koa()
app.use(bodyParser())

app.use(demoRouter.routes()).use(demoRouter.allowedMethods())
app.use(postsRouter.routes()).use(postsRouter.allowedMethods())

// 关键：托管前端 dist
app.use(serve(join(__dirname, '../public')))

const PORT = 3000
app.listen(PORT, () => console.log(`API ready at http://localhost:${PORT}`))