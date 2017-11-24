FROM ubuntu:16.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    apt-utils \
    curl \
    apache2 \
    libapache2-mod-wsgi \
    supervisor \
    graphite-carbon \
    python \
    python-pip \
    build-essential \
    python-dev \
    libcairo2-dev \
    libffi-dev

RUN pip install graphite-api

RUN echo "deb https://packagecloud.io/grafana/stable/debian/ jessie main" >> /etc/apt/sources.list
RUN curl https://packagecloud.io/gpg.key | apt-key add -
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y grafana

RUN cp /usr/share/doc/graphite-carbon/examples/storage-aggregation.conf.example \
       /etc/carbon/storage-aggregation.conf
RUN sed -i 's/ENABLE_LOGROTATION = False/ENABLE_LOGROTATION = True/g' /etc/carbon/carbon.conf
RUN sed -i 's/retentions = 60s:1d/retentions = 60s:90d/g' /etc/carbon/storage-schemas.conf

COPY graphite-api.yaml /etc/

RUN a2dissite 000-default
COPY graphite-api.wsgi /var/www/wsgi-scripts/
COPY graphite-api.conf /etc/apache2/sites-available/
RUN a2ensite graphite-api

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD /usr/bin/supervisord --nodaemon --configuration /etc/supervisor/conf.d/supervisord.conf