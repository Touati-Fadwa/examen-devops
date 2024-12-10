# Étape 1: Utiliser une image de base Maven et Java 21
FROM maven:3.8.4-openjdk-21-slim AS build

# Étape 2: Définir le répertoire de travail
WORKDIR /app

# Étape 3: Copier le fichier pom.xml pour permettre à Maven de télécharger les dépendances
COPY pom.xml .

# Étape 4: Télécharger les dépendances Maven
RUN mvn dependency:go-offline

# Étape 5: Copier les sources
COPY src /app/src

# Étape 6: Compiler l'application
RUN mvn clean package -DskipTests

# Étape 7: Créer l'image finale en utilisant une image de base avec Java 21
FROM openjdk:21-jdk-slim

# Étape 8: Définir une variable d'environnement pour Spring Boot
ENV SPRING_PROFILES_ACTIVE=prod

# Étape 9: Copier le fichier JAR généré depuis l'image de construction
COPY --from=build /app/target/*.jar /app/app.jar

# Étape 10: Exposer le port que votre application Spring Boot écoute
EXPOSE 8080

# Étape 11: Définir le point d'entrée pour démarrer l'application Spring Boot
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
