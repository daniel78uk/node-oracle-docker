# # INSTALL NODE BASE IMAGE (USING NODESOURCE WHEEZY FOR SIZE
FROM node:wheezy

MAINTAINER dan78uk

# ORACLE PATH LIBS
ENV LD_LIBRARY_PATH="/opt/oracle/instantclient"
ENV OCI_HOME="/opt/oracle/instantclient"
ENV OCI_LIB_DIR="/opt/oracle/instantclient"
ENV OCI_INCLUDE_DIR="/opt/oracle/instantclient/sdk/include"

# ORACLE CONF VARS
ENV NLS_LANG="ENGLISH_UNITED KINGDOM.AL32UTF8"
ENV NLS_DATE_FORMAT="YYYY-MM-DD"

COPY ./oracle/linux/ .

RUN apt-get update
RUN apt-get install -y libaio1 build-essential unzip curl && \
  mkdir -p opt/oracle && \
  unzip instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle && \
  unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle && \
  mv /opt/oracle/instantclient_12_1 /opt/oracle/instantclient && \
  ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so && \
  ln -s /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so && \
  echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && ldconfig && \
  rm -rf instantclient-basic-linux.x64-12.1.0.2.0.zip instantclient-sdk-linux.x64-12.1.0.2.0.zip && \
  apt-get clean
