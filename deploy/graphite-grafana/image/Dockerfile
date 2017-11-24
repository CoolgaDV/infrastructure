FROM ubuntu:16.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # auxiliary package for other packages setup
    apt-utils \
    # auxiliary packages for downloading grafana image
    apt-transport-https \
    curl \
    # apache web server (for running graphite api application)
    apache2 \
    libapache2-mod-wsgi \
    # supervisord (for convenience of running multiple services inside single docker container)
    supervisor \
    # carbone (graphite metrics collecting application)
    graphite-carbon \
    # auxiliary packages for graphite api
    python \
    python-pip \
    build-essential \
    python-dev \
    libcairo2-dev \
    libffi-dev

RUN pip install graphite-api

# installing grafana
RUN echo "deb https://packagecloud.io/grafana/stable/debian/ jessie main" >> /etc/apt/sources.list
RUN curl https://packagecloud.io/gpg.key | apt-key add -
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y grafana

# configuring carbone
RUN cp /usr/share/doc/graphite-carbon/examples/storage-aggregation.conf.example \
       /etc/carbon/storage-aggregation.conf
RUN sed -i 's/ENABLE_LOGROTATION = False/ENABLE_LOGROTATION = True/g' /etc/carbon/carbon.conf
RUN sed -i 's/retentions = 60s:1d/retentions = 60s:90d/g' /etc/carbon/storage-schemas.conf

# configuring graphite api
COPY graphite-api.yaml /etc/

# configuring apache for running graphite api
RUN a2dissite 000-default
COPY graphite-api.wsgi /var/www/wsgi-scripts/
COPY graphite-api.conf /etc/apache2/sites-available/
RUN a2ensite graphite-api

# configuring supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# running carbon, apache (with graphite api) and grafana via supervisord
CMD /usr/bin/supervisord --nodaemon --configuration /etc/supervisor/conf.d/supervisord.conf