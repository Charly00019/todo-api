pipeline {
    agent any

    environment {
        // DOCKER_USERNAME = credentials('docker-hub-credentials')
        // DOCKER_PASSWORD = credentials('docker-hub-credentials')
        REGISTRY = "docker.io"  // Change to your registry (e.g., ghcr.io, ECR, etc.)
        IMAGE_NAME = "andrews011/myapp"  // Change this to your actual Docker image name
        TAG = "latest"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Charly00019/todo-api.git'  // Change this to your repo
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $REGISTRY/$IMAGE_NAME:$TAG ."
                }
            }
        }

        stage('Login to Docker Registry') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $REGISTRY"
                }
            }
        }

        stage('Push Image to Registry') {
            steps {
                script {
                    sh "docker push $REGISTRY/$IMAGE_NAME:$TAG"
                }
            }
        }
    }
}
