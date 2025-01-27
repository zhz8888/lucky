# Lucky

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/zhz8888/lucky/build.yml)

## 简介

本项目是[Lucky](https://github.com/gdy666/lucky)的 Docker 镜像源码，补全了原版 Docker 镜像缺失的软件包。

在正式使用前请先阅读[官方文档](https://lucky666.cn/)。

## 快速开始

- 不挂载主机目录，删除容器同时会删除配置

```bash
docker run -d --name lucky --restart=always --net=host zhz1021/lucky
```

- 挂载主机目录，删除容器后配置不会丢失。可替换 `/root/luckyconf` 为主机目录，配置文件夹为 `lucky`

```bash
docker run -d --name lucky --restart=always --net=host -v /root/luckyconf:/goodluck zhz1021/lucky
```

- Docker Compose

```yml
services:
  lucky:
    image: zhz1021/lucky
    container_name: lucky
    volumes:
      - /root/luckyconf:/goodluck
    network_mode: host
    restart: always
```

- UNRAID Docker 模板

```bash
wget -O /boot/config/plugins/dockerMan/templates-user/my-Lucky.xml https://cdn.jsdelivr.net/gh/zhz8888/lucky@main/my-Lucky.xml
```

## 架构支持

- amd64
- i386
- arm64
- armv7

## 可用镜像列表

| 标签           | 镜像名                                  | 大小                                                                                  |
|--------------|--------------------------------------|-------------------------------------------------------------------------------------|
| latest       | `zhz1021/lucky:latest`               | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/latest?label=大小)       |
| latest       | `ghcr.io/zhz8888/lucky:latest`       | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/latest?label=大小)       |
| 2.14.0       | `zhz1021/lucky:2.14.0`               | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0?label=大小)       |
| 2.14.0       | `ghcr.io/zhz8888/lucky:2.14.0`       | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0?label=大小)       |
| 2.14.0-amd64 | `zhz1021/lucky:2.14.0-amd64`         | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-amd64?label=大小) |
| 2.14.0-amd64 | `ghcr.io/zhz8888/lucky:2.14.0-amd64` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-amd64?label=大小) |
| 2.14.0-i386  | `zhz1021/lucky:2.14.0-i386`          | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-i386?label=大小)  |
| 2.14.0-i386  | `ghcr.io/zhz8888/lucky:2.14.0-i386`  | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-i386?label=大小)  |
| 2.14.0-arm64 | `zhz1021/lucky:2.14.0-arm64`         | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-arm64?label=大小) |
| 2.14.0-arm64 | `ghcr.io/zhz8888/lucky:2.14.0-arm64` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-arm64?label=大小) |
| 2.14.0-armv7 | `zhz1021/lucky:2.14.0-armv7`         | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-armv7?label=大小) |
| 2.14.0-armv7 | `ghcr.io/zhz8888/lucky:2.14.0-armv7` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-armv7?label=大小) |

## Credits

[gdy666/lucky](https://github.com/gdy666/lucky)

[fredliang44/derper-docker](https://github.com/fredliang44/derper-docker)