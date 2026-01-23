import Router from 'koa-router';
const router = new Router({ prefix: '/api' });

// 原来的 hello 路由
router.get('/hello', async (ctx) => {
  ctx.body = { msg: 'Hello from Koa+TS' };
});

// 新增的 posts 路由
router.get('/posts', async (ctx) => {
  ctx.body = [
    { _id: '1', title: 'Hello', content: 'World' }
  ];
});

export default router;