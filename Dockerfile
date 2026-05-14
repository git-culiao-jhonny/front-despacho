# ==================== STAGE 1: BUILD ====================
FROM node:20-alpine AS builder
WORKDIR /app

ARG VITE_API_VENTAS=/api/v1/ventas
ARG VITE_API_DESPACHOS=/api/v1/despachos
ENV VITE_API_VENTAS=${VITE_API_VENTAS}
ENV VITE_API_DESPACHOS=${VITE_API_DESPACHOS}

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# ==================== STAGE 2: NGINX ====================
FROM nginxinc/nginx-unprivileged:alpine

# Copiar build de React
COPY --from=builder /app/dist /usr/share/nginx/html

# Copiar configuración de Nginx (para SPA routing)
COPY nginx.conf /etc/nginx/templates/default.conf.template

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
