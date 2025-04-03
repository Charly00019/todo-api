pipeline {
    agent any

    environment {
        REGISTRY = "docker.io"
        IMAGE_NAME = "andrews011/myapp"
        TAG = "latest"
    }

        stages {
        stage('Clone Repository') {
            steps {
                script {
                    checkout([
                        $class: 'GitSCM',
                        branches: [[name: '*/main']],
                        userRemoteConfigs: [[
                            url: 'https://github.com/Charly00019/todo-api.git',
                            credentialsId: 'github_credential'
                        ]]
                    ])
                }
            }
        }
    }
}

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t $REGISTRY/$IMAGE_NAME:$TAG ."
                }
            }
        }

        stage('Login and Push to Docker Registry') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: 'https://index.docker.io/v1/']) {
                    script {
                        sh "docker push $REGISTRY/$IMAGE_NAME:$TAG"
                    }
                }
            }
        }
    }
}
