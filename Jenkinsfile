pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = 'patthechosen/pat_jenkins_apache'
        DOCKERHUB_CREDS = credentials('DockerhubCreds-id')
    }

    stages {
        stage('Source') {
            steps {
                echo 'Checking into GitHub...'
                git branch: 'main', credentialsId: 'GithubCredsok', url: 'https://github.com/patthechosen/CI-CD-Deployment.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the Docker Image...'
                sh 'docker build -t ${DOCKERHUB_REPO}:v${BUILD_NUMBER} .'
                sh 'docker images'
            }
        }

        stage('Docker Login') {
            steps {
                echo 'Logging in to DockerHub...'
                sh 'docker login -u ${DOCKERHUB_CREDS_USR} -p ${DOCKERHUB_CREDS_PSW}'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing the Docker Image to Docker Hub...'
                sh 'docker push ${DOCKERHUB_REPO}:v${BUILD_NUMBER}'
            }
        }

        stage('Manual Approval') {
            steps {
                echo 'Waiting for manual approval...'
                input message: 'Waiting for approval before deployment', ok: 'Deploy'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes...'
                sh 'kubectl apply -f deployment.yaml'
            }
        }

        stage('Destroy Containers') {
            steps {
                echo 'stoping and deleting containers...'
                sh 'docker stop my-apache-app-v${BUILD_NUMBER}'
                sh 'docker rm my-apache-app-v${BUILD_NUMBER}'    
                sh 'docker logout'
            }

            }
        }
    }
}