FROM frooodle/s-pdf:latest

COPY ./configs /configs
COPY ./trainingData /usr/share/tessdata

ENV DOCKER_ENABLE_SECURITY=true \
    SECURITY_ENABLE_LOGIN=true \
    SECURITY_INITIALLOGIN_USERNAME=admin \
    SECURITY_INITIALLOGIN_PASSWORD=stirling \
    HOST='::' \
    PORT=8080

EXPOSE 8080
