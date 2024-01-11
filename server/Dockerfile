# Use an official Node runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install any needed packages
RUN npm install

# Bundle app source inside the container
COPY . .

# Make port 5000 available outside this container
EXPOSE 5000

# Define the command to run the app
CMD ["node", "app.js"]
