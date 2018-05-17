FROM docker.elastic.co/elasticsearch/elasticsearch:5.5.3
COPY config/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
ENV REGION ""
USER root
RUN chown elasticsearch:elasticsearch /usr/share/elasticsearch/config/elasticsearch.yml
USER elasticsearch
WORKDIR /usr/share/elasticsearch
RUN bin/elasticsearch-plugin install discovery-ec2 && bin/elasticsearch-plugin install repository-s3 && sed -e '/^-Xm/s/^/#/g' -i /usr/share/elasticsearch/config/jvm.options
