pipeline {
    agent any
  
  stages {
    stage('Checkout') {
      environment {
        //GOPATH = credentials('JENKINS_HOME')/jobs/credentials('JOB_NAME')/builds/credentials('BUILD_ID')/
        GOPATH = "${env.JENKINS_HOME + '/jobs/' + env.JOB_NAME}"
        PATH = "${$GOPATH + '/bin:' + env.PATH}"
      }
      steps {
        git url: 'https://github.com/getmahen/gojenkinslambda.git'
      }
    }

    stage('Dependencies') {
      steps {
        sh 'printenv'
        sh 'sudo apt-get install -y zip'
        sh 'go version'
        sh 'go get -u github.com/golang/dep/...'
        sh 'dep ensure -v'
      }
    }
  }
}