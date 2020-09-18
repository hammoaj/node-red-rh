FROM registry.access.redhat.com/ubi8/nodejs-12

USER root

RUN dnf -y install make gcc gcc-c++ openssl-devel bzip2-devel python2

RUN mkdir -p /usr/src/node-red /data && \
    useradd --home-dir /usr/src/node-red --gid 0 --no-create-home --uid 1000 node-red && \
    chown -R node-red:root /data && chmod -R g+rwX /data && \
    chown -R node-red:root /usr/src/node-red && chmod -R g+rwX /usr/src/node-red

# Set work directory
WORKDIR /usr/src/node-red

COPY package.json ./

RUN npm install --unsafe-perm --no-update-notifier --only=production

COPY *.js ./
COPY defaults defaults/
COPY nodes nodes/
COPY public public/

RUN chown -R node-red:root /usr/src/node-red

USER node-red
# Env variables
ENV NODE_PATH=/usr/src/node-red/node_modules:/data/node_modules \
    FLOWS=flows.json

EXPOSE 1880

ENTRYPOINT ["npm", "start", "--cache", "/data/.npm", "--", "--userDir", "/data"]

CMD ["--settings" ,"./docker-settings.js"]