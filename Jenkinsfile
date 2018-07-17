#!/usr/bin/env groovy
// pipeline {
//     agent any
//     stages {
//         stage('Build') {
//             steps {
//                 echo 'Building'
//                 sh 'make build'
//                 sh 'ls -la'
//             }
//         }
//         stage('Test') {
//             steps {
//                 echo 'Testing'
//                 sh 'make test'
//             }
//         }
//         stage('Deploy') {
//             steps {
//                 echo 'Deploying'
//             }
//         }
//     }
// }



node {
    def root = tool name: 'Go1.10.3', type: 'go'
    ws("${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/src/github.com/gojenkinslambda/gojenkinslambda") {
        withEnv(["GOROOT=${root}", "GOPATH=${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/", "PATH+GO=${root}/bin"]) {
            env.PATH="${GOPATH}/bin:$PATH"
            
            stage 'Checkout'
        
            git url: 'https://github.com/getmahen/gojenkinslambda.git'
        
            stage 'preTest'
            sh 'go version'
            sh 'go get -u github.com/golang/dep/...'
            sh 'dep ensure -v'
            
            stage 'Test'
            sh 'make test'
            
            stage 'Build'
            sh 'make build'
            
            stage 'Deploy'
            // Do nothing.
        }
    }
}