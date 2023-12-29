FROM node:20-alpine as base

ARG CACHEBUST=1

WORKDIR /usr/src/app

COPY yarn.lock .
COPY package.json .

COPY packages/models/package.json ./packages/models/package.json
COPY packages/models/src ./packages/models/src

COPY packages/ui ./packages/ui

# Setup production node_modules
FROM base as build

RUN yarn

WORKDIR /usr/src/app/packages/ui
RUN yarn build

FROM base as production-dependencies

RUN yarn install --production

FROM node:20-alpine

COPY --from=production-dependencies /usr/src/app/node_modules /usr/src/app/node_modules
COPY --from=base /usr/src/app/packages/ui/package.json /usr/src/app/package.json
COPY --from=build /usr/src/app/packages/ui/build /usr/src/app/build
COPY --from=build /usr/src/app/packages/ui/public /usr/src/app/public

WORKDIR /usr/src/app

RUN chown -R node:node .
USER node

EXPOSE 3000

CMD ["npm", "run", "start"]
