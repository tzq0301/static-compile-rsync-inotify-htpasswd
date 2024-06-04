# htpasswd 静态编译说明

由于难以直接使用 htpasswd 提供的编译参数来编译出静态链接的产物，因此，使用 htpasswd.c 与其依赖的一些文件、库，直接使用 gcc 进行编译

htpasswd.c 与其依赖的一些文件、库，均从 httpd、apr、apr-util 源码经编译后 copy 而出

其中对 `apr_private.h` 进行修改，将引入 `apr_private_common.h` 的那行改为 `#include "apr_private_common.h"`

## 基于 htpasswd 依赖的文件进行编译

已将 htpasswd.c 依赖的文件放置在 htpasswd.bak 文件夹中，直接执行 `bash docker-build.sh` 即可，该脚本构建一个 Docker 镜像，其先安装好编译工具，再调用 `bash build.sh` 进行 htpasswd 的构建

## 基于 httpd、apr、apr-util 编译后的产物进行编译（该方式的主要作用为“留档”）

> [httpd](https://github.com/apache/httpd/tags) 和 [apr & apr-util](https://apr.apache.org/download.cgi) 的下载链接

在机器中安装好编译 httpd、apr、apr-util 所需要的工具后，执行 `bash httpd-build.sh` 即可，该脚本在对 httpd、apr、apr-util 进行编译后，会调用 `bash build.sh` 进行 htpasswd 的构建
