# ====== 前端编译 ======
FROM node:20-alpine AS fe-build
WORKDIR /app

# 关键：复制 workspace 根配置 + 前端代码
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml tsconfig.base.json ./
COPY packages ./packages

RUN npm i -g pnpm@8.15.5 && pnpm install --frozen-lockfile
RUN cd packages/frontend && pnpm build

# ====== 后端运行 ======
FROM node:20-alpine
WORKDIR /app
RUN npm i -g pnpm@8.15.5

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
COPY packages ./packages
RUN pnpm install --prod --frozen-lockfile

# 复制前端 dist 到后端 public
COPY --from=fe-build /app/packages/frontend/dist ./packages/backend/public

RUN cd packages/backend && pnpm build

EXPOSE 3000
CMD ["node", "packages/backend/dist/index.js"]