Run without compose:

```bash
docker run --name artifactory -d -p 8081:8081 -v /path/to/certs:/artifactory_extra_certs docker.bintray.io/jfrog/artifactory-pro:latest
```


But now better use `docker-compose.yml`.
