#!/usr/bin/env groovy

//THIS WORKED
node {
    def root = tool name: 'Golang', type: 'go'
    ws("${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/src/github.com/gojenkinslambda/gojenkinslambda") {
        withEnv(["GOROOT=${root}", "GOPATH=${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/", "PATH+GO=${root}/bin"]) {
            env.PATH="${GOPATH}/bin:$PATH"

            stage 'Checkout'
        
            git url: 'https://github.com/getmahen/gojenkinslambda.git'

            sh 'printenv'

            stage 'Dependencies'
            //sh 'sudo apt-get install -y zip'
            sh 'go version'
            sh 'go get -u github.com/golang/dep/...'
            sh 'dep ensure -v'
            
            stage 'Test'
            sh 'make test'
            
            stage 'Build'
            sh 'make build'
            
            stage 'Zip and package'
            
            sh '''
            cd checkipaddress && zip -v checkipaddress.zip checkipaddress
            '''
            sh 'ls -latr ./checkipaddress'

            stage 'Upload package to AWS S3 bucket'
            sh '''
            set +x 
            export AWS_DEFAULT_REGION=us-west-2 
            aws s3 cp ./checkipaddress/checkipaddress.zip s3://testjenkinsartifacts/checkipaddress.zip
            '''
            
            stage 'Deploy using Terraform'
            sh '''
            set +x
            echo 'Initializing Terraform backend'
            terraform version
            cd `pwd`/infrastructure/terraform
            ls -la
            terraform init -backend-config=./backendConfigs/dev

            echo 'Executing Terraform plan'
            terraform plan
            
            echo 'Executing Terraform apply...'
            terraform apply -lock=false -input=false -auto-approve
            '''
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
