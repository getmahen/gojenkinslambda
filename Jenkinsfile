pipeline {
    agent any
    environment {
        // Some environment variables to be used later
        ARTIFACTPATH = "output"
        OUTPUT = "bundle.tar.gz"
    }
    stages {
        // Just a small stage to notify bitbucket that we're under way
        stage('checkout') {
            steps {
                git url: 'https://github.com/getmahen/gojenkinslambda.git'
            }
        }

        // We could parallelize it, but I've chosen not to, mostly due to resource restrictions
        // The first build-pass will be a golang build environment
        stage('Docker:Go') {
            agent {
                // Use golang
                docker {
                    image 'golang:1.9.2'
                    // Use the same node as the rest of the build
                    reuseNode true
                    // Do go-platform stuff and put my app into the right directory
                    args '-v $WORKSPACE:/go/src/gojenkinslambda'
                }
            }
            steps {
                // While not technically necessary to have the "script" section here
                // it is more consistent with what I do below
                script {
                    // You could split this up into multiple stages if you wanted to
                    stage('Compile:Go') {
                      sh 'ls -la'
                      sh 'sudo apt-get install -y zip'
                      sh 'go version'
                      sh 'go get -u github.com/golang/dep/...'
                      sh 'dep ensure -v'
                    }
                }
            }
        }
    }
}