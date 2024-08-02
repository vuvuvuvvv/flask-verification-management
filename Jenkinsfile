pipeline {
    agent any
    environment {
        dockerHome = tool name: '404Docker', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
        PATH = "${dockerHome}/bin:${env.PATH}"
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
                sh 'docker --version'
                sh 'docker info'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.withServer('unix:///var/run/docker.sock') {
                        echo 'Building Docker image...'
                        sh 'docker build -t vuvuvuvvv/dhtverificationmanagement-flask:latest .'
                    }
                }
            }
        }
        stage('Push Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credential') {
                        echo 'Pushing Docker image...'
                        sh 'docker push vuvuvuvvv/dhtverificationmanagement-flask:latest'
                    }
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
