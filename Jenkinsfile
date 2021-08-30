pipeline{
    agent any

    stages {
        stage('Checkout'){
            steps{
                checkout scm
            }
        }

        stage('Build Docker Image'){
            steps{
                script {
                    app = docker.build("$DOCKER_USERNAME/distroless-python:jenkins")
                }
            }
        }

        stage('Lacework Image Assurance Scan'){
            environment {
                LW_ACCESS_TOKEN = credentials('lacework_access_token')
                LW_SCANNER_SAVE_RESULTS = true
                LW_SCANNER_SCAN_LIBRARY_PACKAGES = true
            }
            steps {
                echo 'Scanning image ...'
                sh "curl -JLO https://github.com/lacework/lacework-vulnerability-scanner/releases/latest/download/lw-scanner-linux-amd64"
                sh "mv lw-scanner-linux-amd64 lw-scanner"
                sh "chmod +x lw-scanner"
                sh "./lw-scanner image evaluate $DOCKER_USERNAME/distroless-python jenkins --build-id ${BUILD_ID}"
            }
        }

        stage('Push Docker Image to Registry'){
            steps{
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("jenkins")
                    }
                }
            }
        }
    }
}
