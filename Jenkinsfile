//  pipeline {
//    agent any
//    stages {
//      stage('Checkout') {
//        steps {
//          //git url: 'https://github.com/getmahen/gojenkinslambda.git'
//          checkout scm
//          sh 'printenv'
//          echo "Running BUILD ID: ${env.BUILD_ID}"
//        }
//      }
//      stage('build') {
//        steps {
//          sh "echo Go path = ${env.GOPATH}"
//          sh 'go version'
//          sh 'make build'
//        }
//      }
//    }
//  }


//Simple Go Docker image
pipeline {
    agent {
        docker { image 'pitchanon/jenkins-golang' }
    }
    stages {
        stage('Golang version check and install dependencies') {
            steps {
                sh 'go version'
                //sh 'apt-get install git'
                //sh 'USER root'
                //sh 'sudo usermod -aG docker Jenkins'
                //sh 'sudo usermod -aG root jenkins'
                //sh 'apk update && apk upgrade && apk add --no-cache bash git openssh && rm -rf /var/cache/apk/*'

                sh 'go get -u github.com/golang/dep/...'
                sh 'dep ensure -v'
            }
        }
        stage('Run Unit tests') {
            steps {
                sh 'make test'
            }
        }
    }
}
