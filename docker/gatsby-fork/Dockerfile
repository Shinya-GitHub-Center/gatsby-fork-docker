# If you want to update docker image by deleting cache,
# please run the command "docker compose build --no-cache (--pull)"

# Basic libraries for frontend dev are already included,
# such as yarn, gcc, g++, make, python, and python3...

# If the lts verson did not work for your gatsby project,
# please change to another node version and re-build your docker

FROM node:lts
# Project repository will be created inside workdir directory
WORKDIR /home/node/workdir
# Update - Upgrade - Install
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y vim less tree jq
# Expose port
EXPOSE 8000 9000
