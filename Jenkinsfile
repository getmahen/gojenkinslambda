pipeline {
    agent any
  
  stages {
    stage('Checkout') {
      environment {
        GOPATH=credentials('JENKINS_HOME')/jobs/credentials('JOB_NAME')/builds/credentials('BUILD_ID')/
        PATH=$GOPATH/bin:credentials('PATH')
      }
      steps {
        git url: 'https://github.com/getmahen/gojenkinslambda.git'
      }
      steps {
        sh 'printenv'
      }
    }

    stage('Dependencies') {
      steps {
        sh 'sudo apt-get install -y zip'
        sh 'go version'
        sh 'go get -u github.com/golang/dep/...'
        sh 'dep ensure -v'
      }
    }
  }
}