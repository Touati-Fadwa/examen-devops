# Étape 1: Utiliser une image de base OpenJDK 21 et installer Maven
FROM openjdk:21-jdk-slim AS build

# Étape 2: Installer Maven
RUN apt-get update && apt-get install -y maven

# Étape 3: Définir le répertoire de travail
WORKDIR /app

# Étape 4: Copier le fichier pom.xml et les sources pour permettre à Maven de télécharger les dépendances
COPY pom.xml .

# Étape 5: Télécharger les dépendances Maven
RUN mvn dependency:go-offline

# Étape 6: Copier les sources
COPY src /app/src

# Étape 7: Compiler l'application
RUN mvn clean package -DskipTests

# Étape 8: Créer l'image finale en utilisant une image de base avec Java 21
FROM openjdk:21-jdk-slim

# Étape 9: Définir une variable d'environnement pour Spring Boot
ENV SPRING_PROFILES_ACTIVE=prod

# Étape 10: Copier le fichier JAR généré depuis l'image de construction
COPY --from=build /app/target/*.jar /app/app.jar

# Étape 11: Exposer le port que votre application Spring Boot écoute
EXPOSE 8080

# Étape 12: Définir le point d'entrée pour démarrer l'application Spring Boot
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
