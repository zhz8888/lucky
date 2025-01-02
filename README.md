# Lucky

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/zhz8888/lucky/build.yml)
[![platfrom](https://img.shields.io/badge/platform-amd64%20%7C%20arm64-brightgreen)](https://hub.docker.com/r/zhz1021/lucky/tags)


## 简介

本项目是基于[Lucky](https://github.com/gdy666/lucky)官方镜像的重构版本，补全了原版镜像缺失的软件包。

在正式使用前请先阅读[官方文档](https://lucky666.cn/)。

## 快速开始

- 不挂载主机目录, 删除容器同时会删除配置

```shell
docker run -d --name lucky --restart=always --net=host zhz1021/lucky
```

- 挂载主机目录, 删除容器后配置不会丢失。可替换 `/root/luckyconf` 为主机目录, 配置文件夹为 `lucky`

```shell
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

```shell
wget -O /boot/config/plugins/dockerMan/templates-user/my-Lucky.xml https://raw.githubusercontent.com/zhz8888/lucky/refs/heads/main/my-Lucky.xml
```

## 架构支持

- amd64
- i386
- arm64
- armv7

## 可用镜像列表

| 标签 | 镜像名 | 大小 |
|------|----------------------------------|------------------------------------------------------------------------------------------------|
| latest | `docker.io/zhz1021/lucky:latest` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/latest?label=大小) |
| latest | `ghcr.io/zhz8888/lucky:latest` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/latest?label=大小) |
| 2.14.0 | `docker.io/zhz1021/lucky:2.14.0` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0?label=大小) |
| 2.14.0 | `ghcr.io/zhz8888/lucky:2.14.0` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0?label=大小) |
| 2.14.0-amd64 | `docker.io/zhz1021/lucky:2.14.0-amd64` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-amd64?label=大小) |
| 2.14.0-amd64 | `ghcr.io/zhz8888/lucky:2.14.0-amd64` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-amd64?label=大小) |
| 2.14.0-i386 | `docker.io/zhz1021/lucky:2.14.0-i386` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-i386?label=大小) |
| 2.14.0-i386 | `ghcr.io/zhz8888/lucky:2.14.0-i386` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-i386?label=大小) |
| 2.14.0-arm64 | `docker.io/zhz1021/lucky:2.14.0-arm64` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-arm64?label=大小) |
| 2.14.0-arm64 | `ghcr.io/zhz8888/lucky:2.14.0-arm64` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-arm64?label=大小) |
| 2.14.0-armv7 | `docker.io/zhz1021/lucky:2.14.0-armv7` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-armv7?label=大小) |
| 2.14.0-armv7 | `ghcr.io/zhz8888/lucky:2.14.0-armv7` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/2.14.0-armv7?label=大小) |

## Credits

- [lucky](https://github.com/gdy666/lucky): 主程序与定制化安装脚本
