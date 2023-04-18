FROM cm2network/steamcmd

WORKDIR /

USER root

COPY entrypoint.sh /home/steam/entrypoint.sh
COPY install.sh /home/steam/install.sh
COPY install_starbound.txt /home/steam/install_starbound.txt
COPY configure_server.sh /home/steam/configure_server.sh
COPY starbound_server.config.template /home/steam/starbound_server.config.template

RUN chmod +x /home/steam/entrypoint.sh && \
    chmod +x /home/steam/install.sh && \
    chmod +x /home/steam/configure_server.sh && \
    chown -R steam:steam /home/steam

RUN mkdir /home/steam/starbound && chown steam /home/steam/starbound
VOLUME /home/steam/starbound

USER steam

EXPOSE 21025/tcp

CMD ["/home/steam/entrypoint.sh"]