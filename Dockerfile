# Use the official Node.js image as the base image
FROM node:16-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and pnpm-lock.yaml files to the container
COPY package.json pnpm-lock.yaml ./

# Install pnpm globally
RUN npm install -g pnpm

# Install project dependencies using pnpm
RUN pnpm install

# Copy the rest of the application source code to the container
COPY . .

# Build the Svelte application
RUN pnpm run build

# Expose the port that the application will run on
EXPOSE 5174

CMD [ "pnpm", "dev", "--", "--port", "5174", "--host" ]