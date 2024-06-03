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

# Stage 2: Serve the application using a simple server
FROM node:21-alpine
WORKDIR /app

# Copy build output and dependencies
COPY --from=build /app/build ./build
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package*.json ./

# Install serve
RUN npm install -g serve

# Expose the port and command to run the app
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
