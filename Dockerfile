FROM jasonrivers/nagios:latest AS build
RUN apt-get update && \
    apt-get install -y git curl gcc make libcurl4-openssl-dev libjansson-dev libglib2.0-dev
RUN git clone https://github.com/alerta/nagios-alerta.git
WORKDIR /nagios-alerta/
RUN make nagios4

FROM jasonrivers/nagios:latest
RUN apt-get update && \
    apt-get install -y libcurl4-openssl-dev libjansson-dev
COPY --from=build /nagios-alerta/src/alerta-neb.o /usr/lib/nagios/alerta-neb.o
