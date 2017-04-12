## 参考 https://github.com/DaoCloud/php-laravel-mysql-sample/blob/master/Dockerfile
FROM php:5.6-apache
MAINTAINER Rod <rod@protobia.tech>

##
## APT 自动安装 PHP 相关的依赖包,如需其他依赖包在此添加
RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libz-dev \
        git \
        wget \
        php5-gd \

    # 官方 PHP 镜像内置命令，安装 PHP 依赖
    && docker-php-ext-install \
        mcrypt \
        mbstring \
        pdo_mysql \
        zip

##
## 安装 node npm 等
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash \
&& apt-get install -y nodejs \
&& npm install -g bower \
&& npm install -g bower-npm-resolver
# && npm install -g cordova ionic


##
## 用完包管理器后安排打扫卫生可以显著的减少镜像大小
RUN apt-get clean \
&& apt-get autoclean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


##
## 安装 Composer，此物是 PHP 用来管理依赖关系的工具
RUN curl -sS https://getcomposer.org/installer \
    | php -- --install-dir=/usr/local/bin --filename=composer


##
##
CMD ["composer"]
