FROM elasticsearch

RUN apt-get update -y
RUN apt-get install -y python-pip
RUN pip install awscli


COPY config/logging.yml /usr/share/elasticsearch/config/
COPY config/elasticsearch.yml /usr/share/elasticsearch/config/

VOLUME /usr/share/elasticsearch/data

COPY docker-entrypoint.sh /

RUN rm -rf /usr/share/elasticsearch/plugins/cloud-aws
RUN rm -rf /usr/share/elasticsearch/plugins/head
RUN plugin -install elasticsearch/elasticsearch-cloud-aws/2.7.1
RUN plugin -install mobz/elasticsearch-head

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 9200 9300

CMD ["elasticsearch"]
