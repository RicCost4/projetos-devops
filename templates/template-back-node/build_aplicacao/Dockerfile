FROM node:18.13.0 AS node

ENV TZ=America/Sao_Paulo

WORKDIR /app

COPY ../ /app
RUN cat .env.exemplo > .env 
RUN rm -rf .env.exemplo
RUN npm cache clean --force
RUN npm get registry
RUN npm install --ignore-scripts
RUN npx prisma generate
RUN npm run build

## - Configurar |??|
EXPOSE |??|

RUN chown -R node:node /app
USER node

CMD ["npm", "run", "start"]