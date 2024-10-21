pipeline {
    agent any
    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credential'
        DOCKER_REGISTRY_URL = 'https://index.docker.io/v1/'
    }
    stages {
        stage('Clone') {
            steps {
                echo 'Cloning repository...'
                git branch: 'dev', credentialsId: 'github-credential', url: 'https://github.com/vuvuvuvvv/flask-verification-management.git'
            }
        }
        stage('Docker Login') {
            steps {
                script {
                    withDockerRegistry(credentialsId: DOCKER_CREDENTIALS_ID, toolName: '404Docker', url: DOCKER_REGISTRY_URL) {
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: DOCKER_CREDENTIALS_ID, toolName: '404Docker', url: DOCKER_REGISTRY_URL) {
                        sh 'docker build -t vuvuvuvvv/dhtverificationmanagement-flask:latest .'
                        sh 'docker push vuvuvuvvv/dhtverificationmanagement-flask:latest'
                    }
                }
            }
        }
    }

    post {
        success {
            mail bcc: '', 
                body: "Build AppServer successfully.\n\n" +
                    "Detail: ${env.BUILD_URL}",
                cc: '', 
                from: '', 
                replyTo: '', 
                subject: "Jenkins Build Success Report: ${env.JOB_NAME} #${env.BUILD_NUMBER}", 
                to: 'nguyenvu260502@gmail.com'
        }
        failure {
            mail bcc: '', 
                body: "Build AppServer failed.\n\n" +
                    "Detail: ${env.BUILD_URL}",
                cc: '', 
                from: '', 
                replyTo: '', 
                subject: "Jenkins Build Failed Report: ${env.JOB_NAME} #${env.BUILD_NUMBER}", 
                to: 'nguyenvu260502@gmail.com'
        }
    }
}