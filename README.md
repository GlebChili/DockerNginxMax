# DockerNginxMax

Yet another containerized build of NGINX with almost every module enabled.

## Usage

The containerized NGINX is run with the following minimum configuration:

```

include /configs/*.conf;

```

So one just should [mount](https://docs.docker.com/storage/bind-mounts/) a folder with configuration files to `/configs` in the container.

## Enabled modules

As mentioned above, this build of NGINX is compiled with almost all non-default modules enabled. Here is the full list:

1. `--with-http_ssl_module`

1. `--with-http_stub_status_module`

1. `--with-http_realip_module`

1. `--with-threads`

1. `--with-stream`

1. `--with-stream_ssl_preread_module`

1. `--with-stream_ssl_module`

1. `--with-http_addition_module`

1. `--with-http_auth_request_module`

1. `--with-http_dav_module`

1. `--with-http_gunzip_module`

1. `--with-http_gzip_static_module`

1. `--with-http_mp4_module`

1. `--with-http_random_index_module`

1. `--with-http_secure_link_module`

1. `--with-http_slice_module`

1. `--with-http_sub_module`

1. `--with-http_v2_module`

1. `--with-mail`

1. `--with-mail_ssl_module`

## Versioning

The builds' version numbers are in form `X.Y.Z.W`, where `X.Y.Z` is a corresponding version of NGINX, and `W` is a revision number of the current dockerized build.
