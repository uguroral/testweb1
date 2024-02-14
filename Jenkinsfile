pipeline {
    agent any
    environment {
        APP_NAME = "testweb"
        RELEASE = "0.0.1"
        DOCKER_USER = "uguroral"
        DOCKER_PASS = 'dockerhub'
        GIT_USERNAME = 'uguroral'
        GIT_PASSWORD = 'github'
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }
    
    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }
        
        stage("Checkout from SCM") {
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/uguroral/testweb1'
            }
        }
        
        stage("Build & Push Docker Image") {
            steps {
                script {
                    docker.withRegistry('', DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('', DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }
        }

        stage('Update GIT') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'github', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh "git config user.email uguroral26@gmail.com"
                        sh "git config user.name uguroral"
                        sh "sed -i 's+uguroral/testweb:.*+${IMAGE_NAME}:${IMAGE_TAG}+g' deployment.yaml"
                        sh "git add deployment.yaml"
                        sh "git commit -m 'Update image tag to ${IMAGE_TAG}'"
                        sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/${GIT_USERNAME}/testweb1.git HEAD:main"
                    }
                }
            }
        }
    }
}
