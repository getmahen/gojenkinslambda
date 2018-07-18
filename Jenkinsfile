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
        withEnv(["GOROOT=${root}", "GOPATH=${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/", "PATH+GO=${root}/bin"]) {
            env.PATH="${GOPATH}/bin:$PATH"
            
            stage 'Checkout'
        
            git url: 'https://github.com/getmahen/gojenkinslambda.git'
        
            sh 'printenv'
            // sh '''
            // echo AWS_ACCESS_KEY_ID == ${TEST}
            // echo AWS_ACCESS_KEY_ID_SCOPE == ${AWS_ACCESS_KEY_ID}
            // ls -la
            // '''
            //s3Upload(file:'README.md', bucket:'testjenkinsartifacts', path:'README.md')

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

            stage 'Upload package to AWS S3 bucket'
            sh '''
            export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} 
            export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} 
            export AWS_DEFAULT_REGION=us-east-2 
            aws s3 cp ./checkipaddress/checkipaddress.zip s3://testjenkinsartifacts/checkipaddress.zip
            '''
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
