# About
Don't you think the first few steps of the preparation of [Gatsby.js](https://www.gatsbyjs.com/) is a little bit annoying?  
Don't you think that please let me develop the project immediately?

Then, this docker image might help you.  
The automation of the first some steps of the development for all gatsby [starters](https://www.gatsbyjs.com/starters/)!  
* This docker does not do GIT FORK technically, but acts like GIT FORK - with special differences - removing unnecessary commits, setting your own name & email address into git config, and changing git branch name to main.

## Git clone to your local machine
1. Download and unzip the source of this repository 
2. Modify the file `./gatsby-fork/variables.txt`
3. Go to the directory where the docker-compose.yml exists
4. `docker compose up -d`
5. `docker exec -it <your container name> bash`
6. Execute preferred shell script file
* `app-init.sh` - if you prefer a regular 'gatsby new' method
* `dl-init.sh` - if you prefer to download a particular point of commit or release from the gatsby repository
```
bash ./app-init.sh
```
```
bash ./dl-init.sh
```
7. Go into the created repository

## Check if the project works well under the designated node.js version
* Develop command : `yarn develop --host 0.0.0.0`  
(required to add host option since this is  inside docker container)
* Run formatter : `yarn format`
* Build command : `yarn build`
* Check built contents : `yarn serve --host 0.0.0.0`
* Test command : `yarn test`
* Clear the cache : `yarn clean`
* Alternative command for develop : `yarn start --host 0.0.0.0`

The project works well, then....

## Git push to your own remote repository
1. Execute `push.sh` (since you are now inside the repository, you need to designate the upper directory to execute the script)
```
bash ../push.sh
```
2. If you want to continue for the another gatsby starter, please erase the created repository (or you can leave it) and modify `./gatsby-fork/variables.txt` file for the next project
* Git credentials are going to be stored inside the docker container. I would recommend to `docker compose down` while you are away from this development for a period of time, in order to keep security.

## How to modify variables.txt
* REPODIR : decide your repository name
* UPSTREAM_ADDR :
  * If you want to use 'gatsby new' method, set the root repository url of the each gatsby starter.
  * If you want to download a particular commit from gatsby starter, right click over the source download link, then copy the url and paste into here. The url has to be finish with `.tar.gz`, so please change the final extension `.zip` to `.tar.gz`

Works with UPSTREAM_ADDR when executing app-init.sh
```
https://github.com/gatsbyjs/gatsby-starter-hello-world
```
Works with  UPSTREAM_ADDR when executing app-init.sh
```
https://github.com/gatsbyjs/gatsby-starter-hello-world.git
```
Works with UPSTREAM_ADDR when executing dl-init.sh
```
https://github.com/gatsbyjs/gatsby-starter-hello-world/archive/refs/heads/master.tar.gz
```
Not work with UPSTREAM_ADDR when executing dl-init.sh
```
https://github.com/gatsbyjs/gatsby-starter-hello-world/archive/refs/heads/master.zip
```
* GIT_UNAME : set your git user name
* GIT_UMAIL : set your git email address
* MYREPO_ADDR : your own remote repository address where you want to git push the gatsby project

## Using VSCode instead of using regular terminal
* You can also use VSCode together with Remote Containers plugin for this docker
* Git History plugin will be installed automatically upon executing the script
* Git credential information will be stored into the default `~/.git-credentials` file which is located at container's home directory.

1. Open root folder of this docker project via VSCode
2. Modify the file `./gatsby-fork/variables.txt`
3. From VSCode's terminal, `docker compose up -d`
4. Attach to the container via Remote Containers plugin
5. You are now in the home directory of the container. From VSCode menu, click 'open folder' and set the directory to `/home/node/workdir/` and click ok
6. You are now in the workdir directory. Please execute your preferred shell script to copy the starter into your local machine, e.g. :
```
bash ./app-init.sh
```
7. From VSCode menu, click 'open folder' and set the directory to `/home/node/workdir/<repository name>/` and click ok (VSCode does not allow you to move to the created respository, so you need to move yourself manually)
8. When you finish, just close the VSCode's container window, and right click the contaier name at the original workspace and select 'stop container' or 'remove container'
9. If you want to continue for the another gatsby starter, please open `workdir` folder via VSCode's menu, then go to the next step (when you go inside or go outside of the repository, you better not use the terminal command move)

## Notices
* If you want to modify or upgrade the base image of this docker, please log in as root user and run the command as root user. (or just modify Dockerfile to stock the process for the next development stage)
```
docker exec -it -u root <your container name> bash
```
* Upon execution of the shell script files, if the same repository name is already created as indicated at `variables.txt` / REPODIR name, the process will be ignored in order to prevent from overriding the existing repository.
* After finished git push your repository, you can now go to the next development stage. Please refer to my another patch of this docker project : [gatsby-dev-docker](https://github.com/Shinya-GitHub-Center/gatsby-dev-docker)

## For your local memo
