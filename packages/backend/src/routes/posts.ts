import Router from 'koa-router'

const router = new Router({ prefix: '/api' })

router.get('/posts', async (ctx) => {
  ctx.body = [
    { _id: '1', title: 'Hello', content: 'World' }
  ]
})

export default router