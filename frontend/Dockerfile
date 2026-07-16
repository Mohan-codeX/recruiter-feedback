# 1. Base image - Lightweight Nginx on Alpine Linux
FROM nginx:1.27-alpine

# 2. Working directory - Where Nginx serves website files from
WORKDIR /usr/share/nginx/html

# 3. Clean environment - Wipe out the default Nginx placeholder page
RUN rm -rf  ./*

# 4. Copy frontend files - Copy everything from the current folder into Nginx
COPY frontend/ .

# 5. Port documentation - Nginx uses port 80 by default
EXPOSE 80

# 6. Startup command - Keep Nginx running continuously
CMD ["nginx", "-g" , "daemon off;"]