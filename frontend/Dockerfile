FROM node:latest

# Web access
EXPOSE 3000
# For Hot reload during development
EXPOSE 35729

WORKDIR /app

ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install
RUN mkdir -p node_modules/.cache && chmod -R 777 node_modules/.cache
RUN npm install react-scripts -g

ADD . /app

CMD ["npm", "start"]