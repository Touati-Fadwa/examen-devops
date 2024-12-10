# Étape 1: Utiliser une image de base Maven et Java
FROM maven:3.8.4-openjdk-17-slim AS build

# Étape 2: Définir le répertoire de travail
WORKDIR /app

# Étape 3: Copier le fichier pom.xml et les sources pour permettre à Maven de télécharger les dépendances
COPY pom.xml .

# Étape 4: Télécharger les dépendances Maven
RUN mvn dependency:go-offline

# Étape 5: Copier le reste des sources
COPY src /app/src

# Étape 6: Compiler l'application
RUN mvn clean package -DskipTests

# Étape 7: Créer l'image finale
FROM openjdk:17-jdk-slim

# Étape 8: Définir une variable d'environnement
ENV SPRING_PROFILES_ACTIVE=prod

# Étape 9: Copier le fichier JAR généré
COPY --from=build /app/target/*.jar app.jar

# Étape 10: Exposer le port que votre application écoute
EXPOSE 8080

# Étape 11: Définir le point d'entrée pour démarrer l'application Spring Boot
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
