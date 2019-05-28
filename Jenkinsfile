pipeline {
    
    agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2'
        }
    } 
    
    stages {
        
        stage('build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        
        stage('test') { 
            steps {
                sh 'mvn test' 
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml' 
                }
            }
        }

        stage('docker build') {
            agent any
            steps {
                script {
                    dockerImage = docker.build("atomist/cd-ms-20:${env.GIT_COMMIT}",  '-f ./Dockerfile .')
                }
            }
        }
    }  
}
