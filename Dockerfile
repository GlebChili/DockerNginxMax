FROM --platform=linux/amd64 ubuntu:20.04 AS build
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y wget && apt install -y build-essential && apt install -y git

WORKDIR /src
RUN wget https://ftp.pcre.org/pub/pcre/pcre-8.44.tar.gz && tar -zxf pcre-8.44.tar.gz
WORKDIR /src/pcre-8.44
RUN ./configure \ 
--target=x86_64 \
&& make  \ 
&& make install

WORKDIR /src
RUN wget http://www.openssl.org/source/openssl-1.1.1g.tar.gz && tar -zxf openssl-1.1.1g.tar.gz
WORKDIR /src/openssl-1.1.1g
RUN ./config --prefix=/usr \
&& make \
&& make install

WORKDIR /src
RUN wget http://zlib.net/zlib-1.2.11.tar.gz && tar -zxf zlib-1.2.11.tar.gz
WORKDIR /src/zlib-1.2.11
RUN ./configure && make && make install

WORKDIR /src
RUN wget https://nginx.org/download/nginx-1.19.10.tar.gz && tar zxf nginx-1.19.10.tar.gz
WORKDIR /src/nginx-1.19.10
RUN ./configure \
--user=root \
--group=root \
--prefix=/usr/local/nginx \
--sbin-path=/usr/local/nginx/nginx \
--conf-path=/usr/local/nginx/nginx.conf \
--pid-path=/usr/local/nginx/nginx.pid \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_realip_module \
--with-threads \
--with-stream \
--with-stream_ssl_preread_module \
--with-stream_ssl_module \
--with-http_addition_module \
--with-http_auth_request_module \
--with-http_dav_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_mp4_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_slice_module \
--with-http_sub_module \
--with-http_v2_module \
--with-mail \
--with-mail_ssl_module \
--with-cc-opt="-static -static-libgcc" \
--with-ld-opt="-static"

RUN make && make install

RUN rm -rf /usr/local/nginx/nginx.conf && rm -rf /usr/local/nginx/nginx.conf.default



FROM --platform=linux/amd64 ubuntu:20.04 AS final

WORKDIR /app

COPY ./nginx.conf .
COPY ./start.sh .

COPY --from=build /usr/local/nginx /usr/local/nginx

EXPOSE 80
EXPOSE 443

STOPSIGNAL 9

ENTRYPOINT ["./start.sh"]