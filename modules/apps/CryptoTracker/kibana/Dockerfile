# https://github.com/elastic/kibana-docker
#FROM docker.elastic.co/kibana/kibana-oss:5.6.8
FROM docker.elastic.co/kibana/kibana-oss:5.5.3
COPY config /usr/share/kibana/config
COPY resources/configure-kibana.sh /tmp/configure-kibana.sh
COPY resources/load_dashboards.py /tmp/load_dashboards.py
COPY resources/objects_visualizations.json /tmp/objects_visualizations.json
CMD ["/bin/sh", "-c", "/tmp/configure-kibana.sh"]
CMD ["/bin/sh", "-c", "/usr/local/bin/kibana-docker"]

