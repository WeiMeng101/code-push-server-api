# 使用官方 Node.js 18 镜像作为基础
FROM node:18

# 安装 Azurite
RUN npm install -g azurite

# 安装 git
RUN apt-get update && apt-get install -y --no-install-recommends git

# 克隆 CodePush Server 仓库
RUN git clone https://github.com/WeiMeng101/code-push-server.git /code-push-server


# 只加入需要的内容


# 切换到 CodePush Server 目录
COPY ./api code-push-server/api/
COPY .env /code-push-server/api/
WORKDIR /code-push-server/api/

# 创建并配置 .env 文件
# RUN echo "AZURE_STORAGE_account=devstoreaccount1" > .env && \
# echo "AZURE_STORAGE_access_key=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==" >> .env && \
# echo "EMULATED=true" >> .env && \
# echo "DEBUG_ENABLE_AUTH=true" >> .env

# 安装依赖
RUN npm install

# 构建项目
RUN npm run build

# 暴露服务器端口（默认 3000）
EXPOSE 3000

# 启动 Azurite 和 CodePush Server
CMD azurite & npm run start:env