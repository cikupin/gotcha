FROM alpine:3.10.1

ENV PATH=$PATH:/opt/gothca

WORKDIR /opt

COPY ./bin/gotcha /opt/
RUN ls /opt
RUN chmod +x /opt/gotcha

RUN adduser --disabled-password --gecos '' gotcha
USER gotcha

CMD ["/opt/gotcha"]