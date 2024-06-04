# htpasswd 静态编译说明

由于难以直接使用 htpasswd 提供的编译参数来编译出静态链接的产物，因此，使用 htpasswd.c 与其依赖的一些文件、库，直接使用 gcc 进行编译

htpasswd.c 与其依赖的一些文件、库，均从 httpd、apr、apr-util 源码经编译后 copy 而出

其中对 `apr_private.h` 进行修改，将引入 `apr_private_common.h` 的那行改为 `#include "apr_private_common.h"`

## httpd、apr、apr-util 编译 

[httpd](https://github.com/apache/httpd/tags) 和 [apr & apr-util](https://apr.apache.org/download.cgi) 的下载链接
