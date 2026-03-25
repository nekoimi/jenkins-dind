# Jenkins DinD

Jenkins Docker in Docker 镜像，集成 Docker CE，支持在 Jenkins 容器内运行 Docker 命令。

[![Docker Image](https://github.com/nekoimi/jenkins-dind/actions/workflows/cr-image.yml/badge.svg)](https://github.com/nekoimi/jenkins-dind/actions/workflows/cr-image.yml)

## 特性

- 基于 Jenkins LTS (JDK21) 版本
- 预装 Docker CE，支持 DinD (Docker in Docker)
- 支持自定义插件安装
- 每周自动构建，保持最新 TLS 版本
- 多架构支持 (amd64, arm64)

## 版本信息

- **Jenkins 版本**: [JENKINS_VERSION](JENKINS_VERSION)
- **基础镜像**: `jenkins/jenkins:lts-jdk21`

## 快速开始

### 使用 Docker Compose

```yaml
version: "3"
services:
  jenkins-dind:
    image: ghcr.io/nekoimi/jenkins-dind:latest
    container_name: jenkins-dind
    hostname: jenkins-dind
    ports:
      - "8080:8080"
      - "50000:50000"
    networks:
      - jenkins-dind-net
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - ./jenkins_data:/var/jenkins_home:rw
    environment:
      JAVA_OPTS: "-server -Xms1024m -Xmx1024m -XX:MaxMetaspaceSize=512m"
    privileged: true
    restart: always

networks:
  jenkins-dind-net:
    driver: bridge
```

启动服务：

```bash
docker-compose up -d
```

### 使用 Docker 命令

```bash
docker run -d \
  --name jenkins-dind \
  --privileged \
  -p 8080:8080 \
  -p 50000:50000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v jenkins_data:/var/jenkins_home \
  -e JAVA_OPTS="-server -Xms1024m -Xmx1024m" \
  --restart always \
  ghcr.io/nekoimi/jenkins-dind:latest
```

## 获取初始管理员密码

```bash
docker exec jenkins-dind cat /var/jenkins_home/secrets/initialAdminPassword
```

## 插件管理

将需要安装的插件添加到 `plugins.txt` 文件，每行一个插件：

```
workflow-aggregator
docker-workflow
git
github
```

镜像构建时会自动安装这些插件。

## 环境变量

| 变量名 | 说明 | 默认值 |
|--------|------|--------|
| `JAVA_OPTS` | JVM 参数 | `-server -Xms1024m -Xmx1024m` |
| `JENKINS_OPTS` | Jenkins 启动参数 | 无 |

## 构建镜像

本地构建：

```bash
docker build -t jenkins-dind:local .
```

## 注意事项

1. **privileged 模式**: 由于需要运行 Docker，容器必须以 `--privileged` 模式运行
2. **Docker Socket**: 通过挂载主机的 Docker Socket 实现 DinD 功能
3. **数据持久化**: 建议将 `jenkins_home` 挂载到宿主机目录或命名卷
4. **安全性**: 在生产环境中请谨慎使用 privileged 模式

## 许可证

MIT License

## 相关链接

- [Docker Hub](https://hub.docker.com/r/jenkins/jenkins)
- [Jenkins 官方文档](https://www.jenkins.io/doc/)
- [GitHub 仓库](https://github.com/nekoimi/jenkins-dind)
