# Use an official Node runtime as a parent image
FROM node:21-alpine

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install any needed packages specified in package.json
RUN npm install

# Bundle app source inside the Docker image
COPY . .

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV MONGO_URI=mongodb://mongo:27017/communicationapp

# Run the application when the container launches
CMD ["node", "src/server.js"]
