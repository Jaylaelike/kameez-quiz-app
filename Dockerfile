# Stage 1: Build the application
FROM node:lts-slim AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Serve the application
FROM node:lts-slim

WORKDIR /app

COPY --from=build /app/package*.json ./
COPY --from=build /app/dist ./dist
COPY --from=build /app/package-lock.json ./package-lock.json

# Install only production dependencies
RUN npm install --only=production

# Install Vite globally to ensure it's available
RUN npm install -g vite


EXPOSE 5173
ENV HOST=0.0.0.0

CMD ["vite", "--host"]