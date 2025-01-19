# Utiliser l'image de base
FROM frooodle/s-pdf:latest

# Copier les fichiers de configuration et autres fichiers nécessaires
COPY ./configs /configs
COPY ./trainingData /usr/share/tessdata

# Définir des variables d'environnement, si nécessaire
ENV DOCKER_ENABLE_SECURITY=true \
    SECURITY_ENABLE_LOGIN=true \
    SECURITY_INITIALLOGIN_USERNAME=admin \
    SECURITY_INITIALLOGIN_PASSWORD=stirling

# Exposer le port sur lequel l'application doit être accessible
EXPOSE 8080

# FROM frooodle/s-pdf:latest

# COPY ./configs /configs
# COPY ./trainingData /usr/share/tessdata

# ENV DOCKER_ENABLE_SECURITY=true \
#     SECURITY_ENABLE_LOGIN=true \
#     SECURITY_INITIALLOGIN_USERNAME=admin \
#     SECURITY_INITIALLOGIN_PASSWORD=stirling \
#     HOST='::' \
#     PORT=8080

# EXPOSE 8080

