FROM debian
LABEL org.opencontainers.image.authors="Joy"
COPY greeter.sh /app/
WORKDIR /app
ENTRYPOINT ["/app/greeter.sh"]

