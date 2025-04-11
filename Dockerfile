ARG UID=200016
ARG GID=200016

FROM phpmyadmin:fpm-alpine
ARG UID
ARG GID

LABEL maintainer="Thien Tran contact@tommytran.io"

RUN apk -U upgrade \
    && apk add libstdc++ \
    && rm -rf /var/cache/apk/*

RUN --network=none \
    addgroup -g ${GID} php-fpm \
    && adduser -u ${UID} --ingroup php-fpm --disabled-password --system php-fpm

COPY --from=ghcr.io/polarix-containers/hardened_malloc:latest /install /usr/local/lib/
ENV LD_PRELOAD="/usr/local/lib/libhardened_malloc.so"

USER php-fpm
