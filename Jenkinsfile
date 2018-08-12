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
        stage('Test') {
            steps {
                sh 'go version'
            }
        }
    }
}
