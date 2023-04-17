FROM cm2network/steamcmd

WORKDIR /

USER root

COPY entrypoint.sh /home/steam/entrypoint.sh
COPY install.sh /home/steam/install.sh
COPY install_starbound.txt /home/steam/install_starbound.txt

RUN chmod +x /home/steam/entrypoint.sh && \
    chmod +x /home/steam/install.sh && \
    chown -R steam:steam /home/steam

USER steam

EXPOSE 21025/tcp

CMD ["/home/steam/entrypoint.sh"]