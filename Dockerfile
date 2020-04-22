FROM php:7.4-cli-alpine AS builder
MAINTAINER Ben Roberts <ben@headsnet.com>

RUN apk --update add curl \
		--repository http://nl.alpinelinux.org/alpine/edge/testing/ && \
		rm /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer && \
	composer global require --no-suggest andres-montanez/magallanes

FROM php:7.4-cli-alpine
COPY --from=builder /root/.composer/vendor /mage

RUN mkdir -p /var/www

WORKDIR /var/www

#ENTRYPOINT ["/mage/bin/mage"]
#ENTRYPOINT ["/var/www"]
