FROM node:lts-alpine
RUN apk add git docker
RUN wget -q https://raw.githubusercontent.com/alis-is/ami/master/install.sh -O /tmp/install.sh && /bin/sh /tmp/install.sh
CMD [ "sleep", "infinity" ]