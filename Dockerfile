ARG base=node:18-bullseye
FROM ${base}
ARG base

RUN apt update; apt install -y git build-essential bash-completion jq
RUN npm install -g npm

ARG REL=master
RUN ( git clone https://github.com/eclipse/thingweb.node-wot.git -b ${REL} /opt/node-wot; \
      cd /opt/node-wot; \
         npm install;   \
         npm run build; \
         npm run link;  \
    )
WORKDIR /opt/node-wot
CMD nodejs /opt/node-wot/packages/cli/dist/cli.js examples/scripts/counter.js

#ENTRYPOINT ["node","/opt/node-wot/packages/cli/dist/cli.js"]
#CMD ["-h"]
