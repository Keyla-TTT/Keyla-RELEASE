FROM mongo:6.0
LABEL authors="Valerio Giannini, Marco Frattarola"

WORKDIR /app

RUN mkdir -p /app/assets && mkdir -p /home/keyla/dictionaries && mkdir -p /app/scripts

COPY ./release-assets/* ./assets/
COPY ./scripts/* ./scripts/

VOLUME /root/keyla/dictionaries
COPY dictionaries/* /root/keyla/dictionaries/

RUN apt-get update && apt-get install -y openjdk-11-jre && rm -rf /var/lib/apt/lists/*

WORKDIR /app/assets
RUN chmod +x keyla-linux
RUN cp keyla-linux /usr/local/bin/keyla
WORKDIR /app

RUN chmod +x /app/scripts/install.sh
RUN /app/scripts/install.sh

RUN chmod +x /app/scripts/start.sh

EXPOSE 9999 27017

VOLUME /data/db

ENTRYPOINT ["/app/scripts/start.sh"]