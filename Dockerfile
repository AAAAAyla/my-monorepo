# ====== 前端编译 ======
FROM node:20-alpine AS fe-build
WORKDIR /app
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
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

# 关键：把前端 dist 复制到后端 public 文件夹
COPY --from=fe-build /app/packages/frontend/dist ./packages/backend/public

RUN cd packages/backend && pnpm build

EXPOSE 3000
CMD ["node", "packages/backend/dist/index.js"]