# 1. Base image - Lightweight Nginx stable version on Alpine Linux
FROM nginx:1.27-alpine

# 2. Configuration - Replace the default configuration with custom reverse proxy rules
COPY reverse-proxy/nginx.conf /etc/nginx/conf.d/default.conf

# 3. Port documentation - The reverse proxy listens for public web traffic on port 80
EXPOSE 80

# 4. Startup command - Force Nginx to run in the foreground so the container stays alive
CMD ["nginx", "-g", "daemon off;"]
