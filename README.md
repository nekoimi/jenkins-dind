# jenkins-dind

Jenkins Docker in Docker Image

### Run

- docker-compose.yml

```yaml
version: "3"
services:
  jenkins-dind:
    image: ghcr.io/nekoimi/jenkins-dind:latest
    container_name: jenkins-dind
    hostname: jenkins-dind
    expose:
      - 8080
    ports:
      - "8080:8080"
    networks:
      - jenkins-dind-net
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./jenkins_data:/var/jenkins_home:rw
    environment:
      JAVA_OPTS : "-server -Xms1024m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m"
    privileged: true
    restart: always

networks:
  jenkins-dind-net:
    driver: bridge
```
