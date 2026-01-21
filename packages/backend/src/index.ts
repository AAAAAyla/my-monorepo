import Koa from 'koa'
import bodyParser from 'koa-bodyparser'
import router from './routes/demo.js'

const app = new Koa()
app.use(bodyParser())
app.use(router.routes()).use(router.allowedMethods())

const PORT = 3000
app.listen(PORT, () => console.log(`API ready at http://localhost:${PORT}`))