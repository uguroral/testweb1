pipeline{
    agent any
        environment {
        APP_NAME = "testweb"
        RELEASE = "0.0.1"
        DOCKER_USER = "uguroral"
        DOCKER_PASS = 'dockerhub'
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
        /*JENKINS_API_TOKEN = credentials("JENKINS_API_TOKEN")*/
    
    }
    
    stages{
        stage("Cleanup Workspace"){
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
            def customTag = "${IMAGE_NAME}:${IMAGE_TAG}"
            def sedScript = "s|uguroral/testweb:latest|uguroral/testweb:${IMAGE_TAG}|g"
            
            // deployment.yaml dosyasındaki latest değerini IMAGE_TAG ile değiştir
            sh "sed -i '' '${sedScript}' path/to/deployment.yaml"
            
            // Docker imajını oluştur ve Docker registry'ye yükle
            docker.withRegistry('',DOCKER_PASS) {
                docker_image = docker.build("${IMAGE_NAME}:${IMAGE_TAG}")
            }
            docker.withRegistry('',DOCKER_PASS) {
                docker_image.push("${IMAGE_NAME}:${IMAGE_TAG}")
                docker_image.push("${IMAGE_NAME}:latest")
            }
        }
    }
}

               

    }

    
}