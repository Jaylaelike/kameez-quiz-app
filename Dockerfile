# Use the official Node.js image as the base image
FROM node:20-alpine AS base

# Set the working directory inside the container
WORKDIR /app

# Install pnpm globally
RUN npm i -g pnpm

# Copy only the necessary files for dependency installation
COPY package.json pnpm-lock.yaml ./

# Install dependencies using pnpm with frozen lockfile
RUN pnpm install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Build the application
RUN pnpm update && pnpm --no-bail build

# Use a new stage for the release
FROM node:20-alpine AS release

# Set the working directory inside the container
WORKDIR /app

# Install pnpm globally
RUN npm i -g pnpm

RUN pnpm run build

# Copy necessary files from the base stage
COPY --from=base /app/package.json /app/pnpm-lock.yaml ./
COPY --from=base /app/node_modules ./node_modules
COPY --from=base /app/dist ./dist

# Copy the rest of the application code
COPY . .



# Expose the port that the application will run on
EXPOSE 3005

# Command to run the application
CMD [ "pnpm", "dev"]