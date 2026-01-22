# ====== 前端编译 ======
FROM node:20-alpine AS fe-build
WORKDIR /build
# 把整个 workspace 拷进去（含锁文件）
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY packages ./packages
RUN npm i -g pnpm@8.15.5 && pnpm install --frozen-lockfile
# 构建前端
RUN cd packages/frontend && pnpm build

FROM node:20-alpine
WORKDIR /app
# ① 拷根锁文件 + 共享配置
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml tsconfig.base.json ./
# ② 拷整个 packages
COPY packages ./packages
RUN npm i -g pnpm@8.15.5 && pnpm install --frozen-lockfile
# ③ 构建后端
RUN cd packages/backend && pnpm build
CMD ["node", "packages/backend/dist/index.js"]