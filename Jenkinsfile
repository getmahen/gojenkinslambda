// pipeline {
//     agent none
//     // environment {
//     // }
//     stages {
//         // Just a small stage to notify bitbucket that we're under way
//         stage('checkout') {
//             steps {
//                 git url: 'https://github.com/getmahen/gojenkinslambda.git'
//             }
//         }

        
//         // We could parallelize it, but I've chosen not to, mostly due to resource restrictions
//         // The first build-pass will be a golang build environment
//         stage('Docker:Go') {
//             agent {
//                 // Use golang
//                 docker {
//                     image 'golang:1.9.2'
//                     // Use the same node as the rest of the build
//                     reuseNode true
//                     // Do go-platform stuff and put my app into the right directory
//                     args '-v $WORKSPACE:/go/src/gojenkinslambda -w /go/src/gojenkinslambda'
//                 }
//             }
//             steps {
                
//                 sh 'go version'
//                 sh 'ls -la'
                
//                 // script {
//                 //     // You could split this up into multiple stages if you wanted to
//                 //     stage('Compile:Go') {
//                 //       sh 'ls -la'
//                 //       sh 'sudo apt-get install -y zip'
//                 //       sh 'go version'
//                 //       sh 'go get -u github.com/golang/dep/...'
//                 //       sh 'dep ensure -v'
//                 //     }
//                 // }
//             }
//         }
//     }
// }



// node {
//         stage("Main build") {

//             git url: 'https://github.com/getmahen/gojenkinslambda.git'

//             docker.image('golang:1.9-alpine').inside {

//               stage("Install Bundler") {
//                 sh 'go version'
//                 sh 'go get -u github.com/golang/dep/...'
//               }

//               stage("Use Bundler to install dependencies") {
//                 sh 'dep ensure -v'
//               }

//               stage("Build package") {
//                 sh 'make build'
//               }

//               // stage("Archive package") {
//               //   archive (includes: 'pkg/*.deb')
//               // }

//            }

//         }

//         // Clean up workspace
//         //step([$class: 'WsCleanup'])

// }

// pipeline {
//     agent {
//         docker { image 'node:7-alpine' }
//     }
//     stages {
//         stage('Test') {
//             steps {
//                 sh 'node --version'
//             }
//         }
//     }
// }

node {
    docker.image('node:7-alpine').inside{
      stage('NodeJs Version') {
        sh 'node --version'
      }
    }
}


// node {
//     stage('checkout') {
//         git url: 'https://github.com/getmahen/gojenkinslambda.git'
//     }
//     stage("build") {
//         writeFile file: "test.txt", text: "test"
//             docker.image("golang:1.9-alpine").inside() { c ->
//                 sh 'go version' // we can run command from docker image
//                 sh 'printenv' // jenkins is passing all envs variables into container
//             }
        
//     }
// }
