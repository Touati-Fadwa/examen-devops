pipeline {
    agent any

    environment {
        DOCKER_HUB_USERNAME = 'ton_nom_utilisateur_dockerhub'  // Remplace par ton nom d'utilisateur Docker Hub
        DOCKER_HUB_PASSWORD = credentials('docker-hub-password')  // Assurez-vous de créer une credential Jenkins pour le mot de passe Docker Hub
        DOCKER_IMAGE_NAME = 'ton_image_springboot'  // Remplace par le nom de ton image Docker
    }

    triggers {
        pollSCM('H/5 * * * *')  // Scrute le repository GitHub toutes les 5 minutes
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/ton_utilisateur/ton_repertoire_springboot.git'  // Remplace par l'URL de ton repository GitHub
            }
        }

        stage('Build Project') {
            steps {
                script {
                    // Effectue le build Maven
                    sh 'mvn clean install -DskipTests'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker
                    sh 'docker build -t $DOCKER_HUB_USERNAME/$DOCKER_IMAGE_NAME .'
                }
            }
        }

        stage('Login to Docker Hub') {
            steps {
                script {
                    // Se connecter à Docker Hub
                    sh "echo $DOCKER_HUB_PASSWORD | docker login --username $DOCKER_HUB_USERNAME --password-stdin"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Pousser l'image vers Docker Hub
                    sh 'docker push $DOCKER_HUB_USERNAME/$DOCKER_IMAGE_NAME'
                }
            }
        }
    }

    post {
        success {
            echo 'Le pipeline s\'est exécuté avec succès!'
        }
        failure {
            echo 'Une erreur s\'est produite pendant l\'exécution du pipeline.'
        }
    }
}
