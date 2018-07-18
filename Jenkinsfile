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


//THIS WORKED
node {
    def root = tool name: 'Golang', type: 'go'
    ws("${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/src/github.com/gojenkinslambda/gojenkinslambda") {
        withEnv(["GOROOT=${root}", "GOPATH=${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/", "PATH+GO=${root}/bin", "AWS_ACCESS_KEY_ID=${TEST}"]) {
            env.PATH="${GOPATH}/bin:$PATH"

            // environment {
            //   AWS_ACCESS_KEY_ID     = credentials('TEST')
            // }
            
            stage 'Checkout'
        
            git url: 'https://github.com/getmahen/gojenkinslambda.git'
        
            sh 'printenv'
            sh '''
            echo AWS_ACCESS_KEY_ID == ${env.TEST}
            '''

            stage 'Dependencies'
            sh 'sudo apt-get install -y zip'
            sh 'go version'
            sh 'go get -u github.com/golang/dep/...'
            sh 'dep ensure -v'
            
            stage 'Test'
            sh 'make test'
            
            stage 'Build'
            sh 'make build'
            
            stage 'Zip and package'
            
            //zip zipFile: './checkipaddress/checkipaddress.zip', dir: './checkipaddress', glob: './checkipaddress/checkipaddress'
            sh '''
            zip -v ./checkipaddress/checkipaddress.zip checkipaddress
            '''
            sh 'ls -latr ./checkipaddress'

            stage 'Upload package'
            // Do nothing.
        }
    }
}


// pipeline {
//   agent any

//   stages {
//     stage('Checkout') {
//       steps {
//         git url: 'https://github.com/getmahen/gojenkinslambda.git'
//         sh 'printenv'
//         sh 'sudo apt-get install -y zip'
//       }
//     }
//     stage('Zip') {
//       steps {
//         sh '''
//         zip checkipaddress.zip .
//         '''
//       }
//     }
//   }
// }
