# Build the Angular app
FROM node:20-alpine as build

WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Serve the Angular app with NGINX
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *

# Copy the built Angular app from the build stage
COPY --from=build /app/dist/cookie-client/browser .

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
