# ====== 前端编译 ======
FROM node:20-alpine AS fe-build
WORKDIR /app

# 复制 workspace 根文件
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml tsconfig.base.json ./
COPY packages ./packages

# 安装依赖并 build 前端
RUN npm i -g pnpm@8.15.5 && \
    pnpm install --frozen-lockfile && \
    cd packages/frontend && \
    pnpm build

# ====== 后端运行 ======
FROM node:20-alpine
WORKDIR /app

# 安装 pnpm
RUN npm i -g pnpm@8.15.5

# 复制所有代码（包括 frontend dist）
COPY --from=fe-build /app/package.json /app/pnpm-lock.yaml /app/pnpm-workspace.yaml ./
COPY --from=fe-build /app/packages ./packages

# 安装生产依赖
RUN pnpm install --frozen-lockfile

# 验证文件存在
RUN ls -la ./packages/backend/src/ && \
    ls -la ./packages/frontend/dist/ 2>/dev/null || echo "no frontend dist"

# 复制前端 dist 到后端 public
RUN mkdir -p ./packages/backend/public && \
    cp -r ./packages/frontend/dist/* ./packages/backend/public/ 2>/dev/null || echo "copy skip"

# 编译后端
RUN cd packages/backend && pnpm build

EXPOSE 3000
CMD ["node", "packages/backend/dist/index.js"]