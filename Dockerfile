FROM node:18-alpine

WORKDIR /app

# Copy dependency manifests first to leverage Docker layer caching.
COPY package*.json ./
RUN if [ -f package-lock.json ]; then npm ci --omit=dev; else npm install --omit=dev; fi

# Copy application code.
COPY . .

ENV NODE_ENV=production
ENV PORT=3001

EXPOSE 3001

# Drop root privileges for runtime security.
USER node

CMD ["npm", "start"]
