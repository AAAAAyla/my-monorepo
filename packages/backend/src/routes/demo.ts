import Router from 'koa-router'
const router = new Router({ prefix: '/api' })

router.get('/hello', async (ctx) => {
  ctx.body = { msg: 'Hello from Koa+TS' }
})

export default router