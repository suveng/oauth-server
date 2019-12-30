# 基础镜像
FROM   192.168.9.233/library/openjdk8-openj9:alpine-slim

# 作者
MAINTAINER suveng

# 设置环境变量,可动态注入,使用docker inspect查看env变量
ENV spring.profiles.active="dev"
ENV TZ=Asia/Shanghai
ENV LANG C.UTF-8

# 添加目标镜像
ADD ./target/*.jar app.jar

EXPOSE 30115

# 执行的容器的command
ENTRYPOINT java -server -Dfile.encoding=UTF-8 -jar /app.jar

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
