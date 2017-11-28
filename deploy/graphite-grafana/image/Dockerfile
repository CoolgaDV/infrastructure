FROM ubuntu:16.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    # auxiliary package for other packages setup
    apt-utils \
    # auxiliary packages for downloading grafana image
    apt-transport-https \
    curl \
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
    libffi-dev \
    nginx

RUN pip install graphite-api gunicorn

# installing grafana
RUN echo "deb https://packagecloud.io/grafana/stable/debian/ jessie main" >> /etc/apt/sources.list && \
    curl https://packagecloud.io/gpg.key | apt-key add - && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y grafana && \
    apt-get clean

# configuring carbone
RUN cp /usr/share/doc/graphite-carbon/examples/storage-aggregation.conf.example \
       /etc/carbon/storage-aggregation.conf && \
    sed -i 's/ENABLE_LOGROTATION = False/ENABLE_LOGROTATION = True/g' /etc/carbon/carbon.conf && \
    sed -i 's/retentions = 60s:1d/retentions = 60s:90d/g' /etc/carbon/storage-schemas.conf

# configuring graphite api
COPY graphite-api.yaml /etc/
COPY graphite.conf /etc/nginx/sites-enabled/

# configuring supervisord
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# grafana web ui
EXPOSE 3000
# graphite carbon
EXPOSE 2003

# grafana database
VOLUME /usr/share/grafana/data
# graphite (whisper) database
VOLUME /var/lib/graphite/whisper

# running carbon, apache (with graphite api) and grafana via supervisord
CMD /usr/bin/supervisord --nodaemon --configuration /etc/supervisor/conf.d/supervisord.conf