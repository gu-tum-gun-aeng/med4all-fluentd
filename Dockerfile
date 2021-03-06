FROM fluent/fluentd:v1.13-1

# Use root account to use apk
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN apk add --no-cache --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && gem install fluent-plugin-kafka \
 && gem install fluent-plugin-cloudwatch-logs \
 && gem install fluent-plugin-rewrite-tag-filter \
 && gem install fluent-plugin-elasticsearch \
 && gem install fluent-plugin-aws-elasticsearch-service \
 && gem install fluent-plugin-influxdb-v2 \
 && gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/
COPY entrypoint.sh /bin/

USER fluent

