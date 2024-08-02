// pipeline {
//     agent any
//     stages {
//         stage('Clone') {
//             steps {
//                 echo 'Cloning repository...'
//                 git branch: 'dev', credentialsId: 'github-credential', url: 'https://github.com/vuvuvuvvv/flask-verification-management.git'
//             }
//         }
//         // stage('Check Docker') {
//         //     steps {
//         //         echo 'Checking Docker...'
//         //         sh 'docker --version'
//         //         sh 'ls -l /var/run/docker.sock'
//         //         sh 'docker info'
//         //     }
//         // }
//         stage('Build Docker Image') {
//             steps {
//                 script {
//                     withDockerRegistry(credentialsId: 'dockerhub-credential', toolName: '404Docker', url: 'https://index.docker.io/v1/') {
//                         sh 'docker build -t vuvuvuvvv/dhtverificationmanagement-flask:latest .'
//                         sh 'docker push vuvuvuvvv/dhtverificationmanagement-flask:latest'
//                     }
//                 }
//             }
//         }
//     }
// }

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
        stage('Check Docker') {
            steps {
                echo 'Checking Docker...'
                bat 'docker --version'
                bat 'docker info'
            }
        }
        stage('Docker Login') {
            steps {
                script {
                    withDockerRegistry(credentialsId: DOCKER_CREDENTIALS_ID, url: DOCKER_REGISTRY_URL) {
                        bat 'docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%'
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    withDockerRegistry(credentialsId: DOCKER_CREDENTIALS_ID, url: DOCKER_REGISTRY_URL) {
                        bat 'docker build -t vuvuvuvvv/dhtverificationmanagement-flask:latest .'
                        bat 'docker push vuvuvuvvv/dhtverificationmanagement-flask:latest'
                    }
                }
            }
        }
    }
}