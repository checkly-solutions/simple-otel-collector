FROM prom/prometheus:latest

USER root
COPY prometheus.yml /etc/prometheus/prometheus.yml.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER nobody
ENTRYPOINT ["/entrypoint.sh"]
