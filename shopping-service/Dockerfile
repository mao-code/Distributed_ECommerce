# node:20-alpine = 目前 LTS 最小映像
FROM node:20-alpine
WORKDIR /app
COPY package*.json .
RUN npm ci --omit=dev        # 只裝 prod 依賴
COPY . .
CMD ["node", "index.js"]

