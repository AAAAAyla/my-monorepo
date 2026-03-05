# ====== 前端编译 ======
FROM node:20-alpine AS fe-build
WORKDIR /app

# 复制 workspace 配置
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml tsconfig.base.json ./
COPY packages ./packages

RUN npm i -g pnpm@8.15.5 && pnpm install --frozen-lockfile
RUN cd packages/frontend && pnpm build

# ====== 后端运行 ======
FROM node:20-alpine
WORKDIR /app
RUN npm i -g pnpm@8.15.5

# 关键：复制完整 workspace（含 devDependencies 用于编译）
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml tsconfig.base.json ./
COPY packages ./packages

# 安装全部依赖（不是 --prod，需要 @types 编译）
RUN pnpm install --frozen-lockfile

# 复制前端 dist
COPY --from=fe-build /app/packages/frontend/dist ./packages/backend/public

# 编译后端
RUN cd packages/backend && pnpm build

# 清理 devDependencies 减小镜像（可选）
RUN pnpm prune --prod

EXPOSE 3000
CMD ["node", "packages/backend/dist/index.js"]