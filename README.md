# Lucky

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/zhz8888/lucky/build.yml)


## 简介

本项目是基于[Lucky](https://github.com/gdy666/lucky)官方镜像的重构版本，使用新版特性启动，同时补全了原版镜像缺失的软件包。目前镜像上传到 Docker Hub 和 Github Container Registry(ghcr.io)上。

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
| v2.14.0 | `docker.io/zhz1021/lucky:v2.14.0` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/v2.14.0?label=大小) |
| v2.14.0 | `ghcr.io/zhz8888/lucky:v2.14.0` | ![大小](https://img.shields.io/docker/image-size/zhz1021/lucky/v2.14.0?label=大小) |

## Credits

- [lucky](https://github.com/gdy666/lucky): 主程序与定制化安装脚本
- [derper-docker](https://github.com/fredliang44/derper-docker): 参考了 Github Actions 的构建脚本
