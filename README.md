# Lucky

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/zhz8888/lucky/build.yml)

## 简介

本项目是自编译的[Lucky](https://github.com/gdy666/lucky)的 Docker 镜像，补全了原版 Docker 镜像缺失的软件包。

本项目使用的版本为`Lucky`，非`万吉`。关于`Lucky`和`万吉`的区别请见[此处](https://lucky666.cn/docs/problemset#%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98)。

在正式使用前请先阅读[官方文档](https://lucky666.cn/docs/intro)。

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

详见[Github Packages](https://github.com/zhz8888/lucky/pkgs/container/lucky/versions)或[Docker Hub](https://hub.docker.com/r/zhz1021/lucky/tags)

## Credits

[gdy666/lucky](https://github.com/gdy666/lucky)

[fredliang44/derper-docker](https://github.com/fredliang44/derper-docker)