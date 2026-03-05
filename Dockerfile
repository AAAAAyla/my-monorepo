# ====== 前端编译 ======
FROM node:20-alpine AS fe-build
WORKDIR /app

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml tsconfig.base.json ./
COPY packages ./packages

RUN npm i -g pnpm@8.15.5 && \
    pnpm install --frozen-lockfile && \
    cd packages/frontend && \
    pnpm build

# ====== 后端运行 ======
FROM node:20-alpine
WORKDIR /app

RUN npm i -g pnpm@8.15.5

# 关键：复制所有根文件（包括 tsconfig.base.json）
COPY --from=fe-build /app/package.json /app/pnpm-lock.yaml /app/pnpm-workspace.yaml /app/tsconfig.base.json ./

# 复制 packages
COPY --from=fe-build /app/packages ./packages

# 验证 tsconfig 存在
RUN ls -la /app/tsconfig.base.json

# 安装依赖
RUN pnpm install --frozen-lockfile

# 复制前端 dist 到后端 public
RUN mkdir -p ./packages/backend/public && \
    cp -r ./packages/frontend/dist/* ./packages/backend/public/

# 编译后端
RUN cd packages/backend && pnpm build

EXPOSE 3000
CMD ["node", "packages/backend/dist/index.js"]