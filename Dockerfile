FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get install -y chromium-browser
RUN apt-get install -y chromium-chromedriver

# Installing Node
ENV NVM_DIR /usr/local/nvm
#ENV NODE_VERSION v20.18.1
#ENV NODE_VERSION v18.0.0
ENV NODE_VERSION v16.20.2
RUN mkdir -p /usr/local/nvm && apt-get update && echo "y" | apt-get install curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
RUN /bin/bash -c "source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION && nvm use --delete-prefix $NODE_VERSION"
ENV NODE_PATH $NVM_DIR/versions/node/$NODE_VERSION/bin
ENV PATH $NODE_PATH:$PATH

RUN apt-get install -y gcc make g++

#COPY package.json .
RUN mkdir /dropzone
WORKDIR /dropzone
COPY ./ /dropzone
RUN cd /dropzone
RUN npm install lmdb-store@latest
RUN npm install

CMD ["npm","run","watch"]