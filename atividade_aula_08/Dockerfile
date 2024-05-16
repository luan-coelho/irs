FROM luancoelhobr/joomla-sas:1.0

ENV JOOMLA_INSTALLATION_DISABLE_LOCALHOST_CHECK 1

# Instalar o MariaDB
RUN apt-get update && \
    apt-get install -y mariadb-server mariadb-client && \
    rm -rf /var/lib/apt/lists/*

# Copiar um script de inicialização para o container
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306 80

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
