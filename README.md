# ⌛️ Gocron

[![Downloads](https://img.shields.io/github/downloads/ouqiang/gocron/total.svg)](https://github.com/gaowei-space/gocron/releases)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)](https://github.com/ouqiang/gocron/blob/master/LICENSE)
[![Release](https://img.shields.io/github/release/gaowei-space/gocron.svg?label=Release)](https://github.com/gaowei-space/gocron/releases)



## 项目简介

> 该项目fork于[ouqiang/gocron](https://github.com/ouqiang/gocron)，依据自己喜好和实际需求进行了功能迭代，发布了 **1.6** 版本。

**[Gocron-定时任务管理系统](https://github.com/gaowei-space/gocron)**，使用Go语言开发的轻量级定时任务集中调度和管理系统, 用于替代**Linux-crontab**

## 迭代

### v1.6

* 优化整体**界面样式与布局**，包括界面色系，列表，详情，按钮组，分页等
* 调整权限等级，增加**超级管理员**，可以管理所有任务；**管理员**调整为管理自己的任务和查看其他任务和日志，普通用户与原有权限一致，仅可查看所有任务和日志
* 任务详情页增加快捷选择crontab按钮组
* 任务详情页支持更改任务状态
* 任务列表支持**标签**,**命令**搜索

## 备注

需安装Go1.19+, Node.js, Yarn，musl编译器

## 开发前置

<details>
<summary>安装go，展开查看</summary>

```shell
# 官网 https://go.dev/dl/

# 1、下载解压重命名
wget https://go.dev/dl/go1.19.13.linux-amd64.tar.gz
tar -xzf go1.19.13.linux-amd64.tar.gz -C /usr/local/
mv /usr/local/go /usr/local/go1.19

# 2、配置环境变量
nano /etc/profile

# Go
export GO111MODULE=on
export GOROOT=/usr/local/go1.19
export GOPATH=/root/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOROOT/bin:$GOBIN

# 3、使配置文件生效
reboot 或 source /etc/profile

# 4、查看是否安装成功
go version
```
</details>

<details>
<summary>安装node.js和yarn，展开查看</summary>

```shell
# nvm项目地址 https://github.com/nvm-sh/nvm
# node.js版本必须“大于等于4 小于等于9”，安装nvm管理node.js版本

# 1、安装nvm并使配置文件生效
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
reboot 或 source ~/.bashrc

# 2、查看是否安装成功
nvm -v

# 3、安装node.js（选择LTS版本）并查看是否安装成功
nvm install 8.17.0
node -v && npm -v

# 4、安装yarn并查看是否安装成功
npm install -g yarn
yarn -v
```
</details>

#### 本地编译前置
<details>
<summary>安装musl编译器，展开查看</summary>

```shell
# 官网 https://musl.libc.org/

# 1、下载解压编译安装
wget https://musl.libc.org/releases/musl-1.2.4.tar.gz
tar xzf musl-1.2.4.tar.gz
cd musl-1.2.4
./configure 
make
make install

# 2、配置环境变量
nano /etc/profile

# musl编译器
export PATH=$PATH:/usr/local/musl/bin

# 3、使配置文件生效
reboot 或 source /etc/profile

# 4、查看是否安装成功
musl-gcc -v
```
</details>

#### 交叉编译前置
<details>
<summary>安装musl交叉编译工具链，展开查看</summary>

```shell
# 交叉编译环境
宿主机(host)  :amd64 (x86_64) linux
目标机(target):amd64 (x86_64), armv7l, arm64, riscv64 linux

# 适用于amd64 (x86_64)平台的交叉编译工具链的网站
https://toolchains.bootlin.com/toolchains.html

# 下面对应的交叉编译工具链名称
x86-64--musl--stable
armv7-eabihf--musl--stable
aarch64--musl--stable
riscv64-lp64d--musl--stable

# musl交叉编译工具链安装示例，顺序为上面目标机(target)标的顺序

# 1、网站下载工具链后新建目录进行统一管理并解压
mkdir -p /usr/local/toolchains
tar -xjf x86-64--musl--stable-2023.11-1.tar.bz2 -C /usr/local/toolchains/
tar -xjf armv7-eabihf--musl--stable-2023.11-1.tar.bz2 -C /usr/local/toolchains/
tar -xjf aarch64--musl--stable-2023.11-1.tar.bz2 -C /usr/local/toolchains/
tar -xjf riscv64-lp64d--musl--stable-2023.11-1.tar.bz2 -C /usr/local/toolchains/

# 2、配置环境变量
nano /etc/profile

# musl交叉编译工具链
export PATH=$PATH:/usr/local/toolchains/x86-64--musl--stable-2023.11-1/bin
export PATH=$PATH:/usr/local/toolchains/armv7-eabihf--musl--stable-2023.11-1/bin
export PATH=$PATH:/usr/local/toolchains/aarch64--musl--stable-2023.11-1/bin
export PATH=$PATH:/usr/local/toolchains/riscv64-lp64d--musl--stable-2023.11-1/bin

# 3、使配置文件生效
reboot 或 source /etc/profile

# 4、查看是否安装成功
x86_64-linux-gcc -v
arm-linux-gcc -v
aarch64-linux-gcc -v
riscv64-linux-gcc -v
```
</details>

## 开发
```shell
# 1、下载项目并切换到项目目录
git clone https://github.com/wss489038/gocron.git
cd gocron/

# 2、安装前端依赖
make install-vue

# 3、打包

# 本地编译
# 生成当前系统的静态二进制文件压缩包，仅在linux系统下进行过测试
make package

# 交叉编译
# 生成linux系统下amd64，armv7l，arm64，riscv64平台的静态二进制文件压缩包
make package-amd64
make package-armv7l
make package-arm64
make package-riscv64
```

## 命令
```shell
gocron
  -v 查看版本

gocron web
  --host 默认0.0.0.0
  -p 端口, 指定端口, 默认5920
  -e 指定运行环境, dev|test|prod, dev模式下可查看更多日志信息, 默认prod
  -h 查看帮助

gocron-node
  -allow-root *nix平台允许以root用户运行
  -s ip:port 监听地址
  -enable-tls 开启TLS
  -ca-file   CA证书文件  
  -cert-file 证书文件
  -key-file 私钥文件
  -h 查看帮助
  -v 查看版本
```

## 截图


![列表](https://user-images.githubusercontent.com/10205742/184531121-f5faa1a9-4d13-4132-a96d-848375765cda.jpg)



![日志](https://user-images.githubusercontent.com/10205742/184531126-0f159cda-8774-4185-9132-194e66cd5d3c.jpg)



![节点](https://user-images.githubusercontent.com/10205742/184531128-7a9a07a9-cac2-4dea-a37a-5cb57479a528.jpg)



![webhook](https://user-images.githubusercontent.com/10205742/184531159-582fd407-bed1-4ed4-a469-e8b9d5af67cb.jpg)





## 功能特性

- Web界面管理定时任务

- crontab时间表达式, 精确到秒

- 任务执行失败可重试

- 任务执行超时, 强制结束

- 任务依赖配置, A任务完成后再执行B任务

- 账户权限控制

- 任务类型

  - shell任务

  > 在任务节点上执行shell命令, 支持任务同时在多个节点上运行

  - HTTP任务

  > 访问指定的URL地址, 由调度器直接执行, 不依赖任务节点

- 查看任务执行结果日志

- 任务执行结果通知, 支持邮件、Slack、Webhook

#### 了解更多

- 原作 [https://github.com/ouqiang/gocron](https://github.com/ouqiang/gocron)