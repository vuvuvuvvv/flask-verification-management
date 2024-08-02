pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                git branch: 'dev', credentialsId: 'github-credential', url: 'https://github.com/vuvuvuvvv/flask-verification-management.git'
            }
        }
        stage('Push Docker Hub') {
            steps {
                withDockerRegistry(credentialsId: 'dockerhub-credential', url: "") {
                    sh 'docker build -t vuvuvuvvv/dhtverificationmanagement-flask:latest .'
                    sh 'docker push vuvuvuvvv/dhtverificationmanagement-flask:latest'
                }
            }
        }
    }
}
