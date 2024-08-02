pipline {
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
                    // some block
                    sh label: '', script 'docker build -t vuvuvuvvv/dhtverificationmanagement-flask:latest .'
                    sh label: '', script 'docker push vuvuvuvvv/dhtverificationmanagement-flask:latest .'
                }
            }
        }
    }
}