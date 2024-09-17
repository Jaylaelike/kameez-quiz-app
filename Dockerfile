# Use the official Node.js image as the base image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and pnpm-lock.yaml files to the container
COPY package.json pnpm-lock.yaml ./

RUN pnpm install --frozen-lockfile

COPY . .
RUN pnpm update
RUN pnpm --no-bail build

# Build the Svelte application
RUN pnpm run build

# Expose the port that the application will run on
EXPOSE 5174

CMD [ "pnpm", "dev", "--", "--port", "5174", "--host" ]