ARG base=node:18-bookworm
FROM ${base}
ARG base

RUN apt update; apt install -y git build-essential bash-completion jq
RUN npm install -g npm

ARG REPO=https://github.com/eclipse/thingweb.node-wot.git -b master
RUN ( git clone ${REPO} /opt/node-wot; \
      cd /opt/node-wot; \
         npm install;   \
         npm run build; \
         npm run link;  \
    )
WORKDIR /opt/node-wot
CMD nodejs /opt/node-wot/packages/cli/dist/cli.js examples/scripts/counter.js

#ENTRYPOINT ["node","/opt/node-wot/packages/cli/dist/cli.js"]
#CMD ["-h"]
