## Jfrog Artifactory OSS


Copied from here https://www.jfrog.com/confluence/display/JFROG/Installing+Artifactory#114759846aa77ee5734e34d7b8d6fba728e7f646f

Unpack jrfog oss:

```bash
    tar -xvf jfrog-artifactory-<pro|oss|jcr|cpp-ce>-<version>-compose.tar.gz
```
.env file included within the Docker-Compose archive

This .env file is used by docker-compose and is updated during installations and upgrades.

Notice that some operating systems do not display dot files by default. If you make any changes to the file, remember to backup before an upgrade.

Run the script to setup folders with required ownership. This is an interactive script.

```bash
bash ./config.sh
```

Customize the product configuration (optional) including database, Java Opts, and filestore. Depending on your choices, a selected docker-compose.yaml will be available in the extracted folder. However, there are a few docker-compose templates in the directory templates. You can choose any template and copy it to the extracted folder as docker-compose.yaml. 

For Docker installations, verify that the host's ID shared.node.id  and IP shared.node.ip are added to the system.yaml . 

If these are not manually added, they are automatically resolved as the container's IP, meaning other nodes and services will not be able to reach this instance.

Docker for Mac

When you use Docker Compose in Mac, /etc/localtime might not work as expected since it might not be a shared location in the docker-for-mac settings.

You can remove the following line from the selected docker-compose.yaml file to avoid installation issues.
```
- /etc/localtime:/etc/localtime:ro
```

Manage Artifactory using native Docker Compose commands, docker-compose -p rt <action> command.
Run this command from the extracted folder.
Examples
# Starting from 7.8.x, PostgreSQL needs to be started before starting the other services.

```bash
docker-compose -p rt-postgres -f docker-compose-postgres.yaml up -d
docker-compose -p rt up -d
docker-compose -p rt ps
docker-compose -p rt down
```

Access Artifactory from your browser at:  http://SERVER_ HOSTNAME:8082/ui/ .  For example, on your local machine: http://localhost:8082/ui/. 

Check Artifactory Log.

```bash
docker-compose -p rt logs
```