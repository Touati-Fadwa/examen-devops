# Étape 1: Utiliser une image de base Java
FROM openjdk:17-jdk-slim AS build

# Étape 2: Définir le répertoire de travail
WORKDIR /app

# Étape 3: Copier le fichier JAR généré dans l'image
COPY target/*.jar app.jar

# Étape 4: Exposer le port que votre application écoute
EXPOSE 8080

# Étape 5: Définir le point d'entrée pour démarrer l'application Spring Boot
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
