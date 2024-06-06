# Stage 1: Build the application
FROM node:21-alpine as build
WORKDIR /app

# Build args
ARG REACT_APP_API_BASE_URL

# Environment vars
ENV REACT_APP_API_BASE_URL=$REACT_APP_API_BASE_URL

# Install app dependencies and build the app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Serve the application using NGINX
FROM nginx:alpine
WORKDIR /app

# Copy build output to NGINX html directory
COPY --from=build /app/build /usr/share/nginx/html

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy env script
COPY env.sh /docker-entrypoint.d/

# Give execute permission to the script
RUN chmod +x /docker-entrypoint.d/env.sh

# Expose the port
EXPOSE 80

# Command to run NGINX
CMD ["sh", "-c", "/docker-entrypoint.d/env.sh && nginx -g 'daemon off;'"]
