FROM node:20-alpine as base

WORKDIR /usr/src/app

COPY yarn.lock .
COPY package.json .

COPY packages/models/package.json ./packages/models/package.json
COPY packages/models/src ./packages/models/src

COPY packages/api/src ./packages/api/src

COPY packages/api/tsconfig.json ./packages/api/tsconfig.json
COPY packages/api/tsconfig.build.json ./packages/api/tsconfig.build.json
COPY packages/api/package.json ./packages/api/package.json

FROM base as build

RUN yarn

WORKDIR /usr/src/app/packages/api
RUN yarn build

FROM base as production-dependencies

RUN yarn install --production

FROM node:20-alpine

COPY --from=production-dependencies /usr/src/app/node_modules /usr/src/app/node_modules
COPY --from=build /usr/src/app/packages/api/package.json /usr/src/app/package.json
COPY --from=build /usr/src/app/packages/api/dist /usr/src/app

WORKDIR /usr/src/app

RUN chown -R node:node .
USER node

EXPOSE 5000

CMD ["npm", "run", "start"]
