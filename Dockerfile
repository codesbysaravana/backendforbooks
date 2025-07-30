# Use Node.js LTS (Long Term Support) slim version as base
FROM node:18-slim

# Set working directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies
# Use npm ci for clean install from package-lock.json
# Use --only=production to exclude dev dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Expose the port the app runs on
EXPOSE 5000

# Set NODE_ENV
ENV NODE_ENV=production

# Create a non-root user and switch to it
# This is a security best practice
RUN groupadd -r nodeapp && \
    useradd -r -g nodeapp -s /bin/false nodeuser && \
    chown -R nodeuser:nodeapp /usr/src/app

USER nodeuser

# Start the application
CMD ["node", "server.js"]
