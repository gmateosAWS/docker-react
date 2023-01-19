# PRODUCTION Dockerfile

# BUILD PHASE: we just need to generate the /build distribution
FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# RUN PHASE: we just need the Nginx server and the files from the previous phase
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html