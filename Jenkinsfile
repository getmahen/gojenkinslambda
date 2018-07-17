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
    def root = tool name: 'Golang', type: 'go'
    ws("${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/src/github.com/gojenkinslambda/gojenkinslambda") {
        withEnv(["GOROOT=${root}", "GOPATH=${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/", "PATH+GO=${root}/bin"]) {
            env.PATH="${GOPATH}/bin:$PATH"
            
            stage 'Checkout'
        
            git url: 'https://github.com/getmahen/gojenkinslambda.git'
        
            sh 'printenv'
            sh "BUILD_ID== ${env.BUILD_ID}"
            sh "JENKINS_URL== ${env.JENKINS_URL}"
            sh "JENKINS_HOME== ${env.JENKINS_HOME}"
            sh "JOB_NAME== ${env.JOB_NAME}"

            stage 'preTest'
            sh 'go version'
            sh 'go get -u github.com/golang/dep/...'
            sh 'dep ensure -v'
            
            stage 'Test'
            sh 'make test'
            
            stage 'Build'
            sh 'make build'
            sh 'ls -la'
            
            stage 'Deploy'
            // Do nothing.
        }
    }
}