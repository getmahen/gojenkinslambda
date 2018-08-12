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
        docker { image 'golang:1.9-alpine' }
    }
    stages {
        stage('Golang version check and install dependencies') {
            steps {
                sh 'go version'
                sh 'apt-get install git'
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
