#!/bin/sh
sed -e "s|\${CHECKLY_ACCOUNT_ID}|${CHECKLY_ACCOUNT_ID}|g" \
    -e "s|\${CHECKLY_PROMETHEUS_BEARER_TOKEN}|${CHECKLY_PROMETHEUS_BEARER_TOKEN}|g" \
    -e "s|\${CORALOGIX_API_KEY}|${CORALOGIX_API_KEY}|g" \
    /etc/prometheus/prometheus.yml.template > /prometheus/prometheus.yml

exec /bin/prometheus \
  --config.file=/prometheus/prometheus.yml \
  --storage.tsdb.path=/prometheus \
  --web.console.libraries=/usr/share/prometheus/console_libraries \
  --web.console.templates=/usr/share/prometheus/consoles
