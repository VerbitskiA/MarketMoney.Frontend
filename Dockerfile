#STAGE 1
# Use official node image as the base image
FROM node:20.11-alpine as build

# Set the working directory
WORKDIR /usr/local/app

# Add the source code to app
COPY ./ /usr/local/app/

RUN npm install
#RUN npx ngcc --properties es2023 browser module main --first-only --create-ivy-entry-points
RUN npm run build

#STAGE 2
FROM nginx:stable
COPY --from=build /usr/local/app/dist/market-money.frontend/browser/ /usr/share/nginx/html
EXPOSE 80
