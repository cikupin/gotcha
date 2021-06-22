FROM alpine:3.10.1

ENV PATH=$PATH:/opt/gothca

WORKDIR /opt/gothca
COPY ./bin/gotcha /opt/gothca/
RUN chmod +x /opt/gotcha/gotcha

RUN adduser --disabled-password --gecos '' gotcha
USER gotcha

CMD ["/opt/gotcha/gotcha"]