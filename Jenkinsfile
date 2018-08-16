#!/usr/bin/env groovy

//THIS WORKED
// node {
//     def root = tool name: 'Golang', type: 'go'
//     ws("${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/src/github.com/gojenkinslambda/gojenkinslambda") {
//         withEnv(["GOROOT=${root}", "GOPATH=${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/", "PATH+GO=${root}/bin"]) {
//             env.PATH="${GOPATH}/bin:$PATH"

//             stage 'Checkout'
        
//             git url: 'https://github.com/getmahen/gojenkinslambda.git'

//             sh 'printenv'

//             stage 'Dependencies'
//             //sh 'sudo apt-get install -y zip'
//             sh 'go version'
//             sh 'go get -u github.com/golang/dep/...'
//             sh 'dep ensure -v'
            
//             stage 'Test'
//             sh 'make test'
            
//             stage 'Build'
//             sh 'make build'
            
//             stage 'Zip and package'
            
//             sh '''
//             cd checkipaddress && zip -v checkipaddress.zip checkipaddress
//             '''
//             sh 'ls -latr ./checkipaddress'

//             stage 'Upload package to AWS S3 bucket'
//             sh '''
//             set +x 
//             export AWS_DEFAULT_REGION=us-west-2 
//             aws s3 cp ./checkipaddress/checkipaddress.zip s3://testjenkinsartifacts/checkipaddress.zip
//             '''
            
//             stage 'Deploy using Terraform'
//             sh '''
//             set +x
//             echo 'Initializing Terraform backend'
//             terraform version
//             cd `pwd`/infrastructure/terraform
//             ls -la
//             terraform init -backend-config=./backendConfigs/dev

//             echo 'Executing Terraform plan'
//             terraform plan
            
//             echo 'Executing Terraform apply...'
//             terraform apply -lock=false -input=false -auto-approve
//             '''
//         }
//     }
// }


//THIS WORKED - With Multi STAGES
// node {
//     def root = tool name: 'Golang', type: 'go'
//     ws("${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/src/github.com/gojenkinslambda/gojenkinslambda") {
//         withEnv(["GOROOT=${root}", "GOPATH=${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/", "PATH+GO=${root}/bin"]) {
//             env.PATH="${GOPATH}/bin:$PATH"

//             stage('Checkout'){
//                     echo 'Checking out SCM'
//                     checkout scm
//                     sh 'printenv'
//                 }

//             stage('Install Dependencies'){
//               //sh 'sudo apt-get install -y zip'
//               sh 'go version'
//               sh 'go get -u github.com/golang/dep/...'
//               sh 'dep ensure -v'
//             }

//              stage('Run Unit tests...'){
//               sh 'make test'
//             }

//             stage('Build and Package...'){
//               sh 'make package'
//             }

//             stage('Upload package to AWS S3...'){
//               sh 'export AWS_DEFAULT_REGION=us-west-2'
//               sh 'aws s3 cp ./checkipaddress/checkipaddress.zip s3://testjenkinsartifacts/checkipaddress.zip'
//             }
//         }
//     }
// }



////VERSION THAT BUILDS THE ENTIRE BUILD ARTIFIACTS (Go Binary and Infrastructure dir) - ALSO Uses buildparameters
node {
  //properties([parameters([string(defaultValue: 'hello', description: '', name: 'myparam', trim: true), string(defaultValue: 'dev', description: '', name: 'deploy_env', trim: true)])])
  // parameters {
  //       string(name: 'deployenv', defaultValue: 'dev', description: 'Targeted Environment to build')
  //   }

    def root = tool name: 'Golang', type: 'go'
    ws("${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/src/github.com/gojenkinslambda/gojenkinslambda") {
        withEnv(["GOROOT=${root}", "GOPATH=${JENKINS_HOME}/jobs/${JOB_NAME}/builds/${BUILD_ID}/", "PATH+GO=${root}/bin"]) {
            env.PATH="${GOPATH}/bin:$PATH"
            def packageName = "buildartifacts-${env.BUILD_ID}"

            print "DEBUG: Build triggered for ${params.deployenv} environment..."

            stage('Checkout'){
                    echo 'Checking out SCM'
                    checkout scm
            }

            stage('Validate'){
                    echo 'Validating terraform...'
                    dir('infrastructure/terraform')
                    sh 'terraform validate'
            }

            stage('Install Dependencies'){
              sh 'go version'
              sh 'go get -u github.com/golang/dep/...'
              sh 'dep ensure -v'
            }

             stage('Run Unit tests...'){
              sh 'make test'
            }

            stage('Build and Package...'){
              sh "make packageall PACKAGE_NAME=${packageName}"
            }

            stage('Upload package to AWS S3...'){
              sh 'export AWS_DEFAULT_REGION=us-west-2'
              sh "aws s3 cp ${packageName}.zip s3://testjenkinsartifacts/${params.deployenv}/${packageName}.zip"
            }
        }
    }
}