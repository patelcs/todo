FROM node:22 AS client-build
WORKDIR /user/local/app
COPY client/package.json client/package-lock.json ./
RUN npm ci
COPY client ./
RUN npm run build


FROM node:22 AS backend-build
WORKDIR /user/local/app
COPY backend/package.json backend/package-lock.json ./
RUN npm ci --omit=dev

FROM node:22-slim AS final
WORKDIR /user/local/app
ENV NODE_ENV=production
COPY --from=backend-build /user/local/app/node_modules ./node_modules
COPY backend/package.json ./
COPY backend/src ./src
COPY --from=client-build /user/local/app/dist ./src/static
EXPOSE 3000
CMD ["node", "src/index.js"]

