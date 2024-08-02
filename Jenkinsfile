pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                echo 'Cloning repository...'
                git branch: 'dev', credentialsId: 'github-credential', url: 'https://github.com/vuvuvuvvv/flask-verification-management.git'
            }
        }
        stage('Check Docker') {
            steps {
                echo 'Checking Docker...'
                sh 'docker --version'
            }
        }
        stage('Push Docker Hub') {
            steps {
                echo 'Building and pushing Docker image...'
                withDockerRegistry(credentialsId: 'dockerhub-credential', url: "") {
                    sh 'docker build -t vuvuvuvvv/dhtverificationmanagement-flask:latest .'
                    sh 'docker push vuvuvuvvv/dhtverificationmanagement-flask:latest'
                }
            }
        }
    }
}


// pipeline {
//     agent any
//     stages {
//         stage('Clone') {
//             steps {
//                 git branch: 'dev', credentialsId: 'github-credential', url: 'https://github.com/vuvuvuvvv/flask-verification-management.git'
//             }
//         }
//         stage('Push Docker Hub') {
//             steps {
//                 withDockerRegistry(credentialsId: 'dockerhub-credential', url: "") {
//                     sh 'docker build -t vuvuvuvvv/dhtverificationmanagement-flask:latest .'
//                     sh 'docker push vuvuvuvvv/dhtverificationmanagement-flask:latest'
//                 }
//             }
//         }
//     }
// }
