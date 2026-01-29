# Stirling-PDF v2.1.4 - testing RAM usage
FROM frooodle/s-pdf:2.1.4

# Copier les fichiers de configuration et autres fichiers nécessaires
COPY ./configs /configs
COPY ./trainingData /usr/share/tessdata

# Définir des variables d'environnement, si nécessaire
ENV DOCKER_ENABLE_SECURITY=true \
    SECURITY_ENABLE_LOGIN=true \
    SECURITY_INITIALLOGIN_USERNAME=admin \
    SECURITY_INITIALLOGIN_PASSWORD=stirling \
    JAVA_TOOL_OPTIONS="-Xms128m -Xmx6144m -XX:+UseG1GC -XX:+UseStringDeduplication"

# Exposer le port sur lequel l'application doit être accessible
EXPOSE 8080

