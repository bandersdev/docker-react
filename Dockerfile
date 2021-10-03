FROM node:alpine as build

WORKDIR /app

COPY --chown=node:node package.json .
RUN npm install 
# No need for volumes for this production build
COPY . .
# Builds to /app/build
RUN npm run build

FROM nginx as runner

# The destination dir is from the nginx docker hub documentation
COPY --from=build /app/build /usr/share/nginx/html

# Can use the default command of the nginx container