//  pipeline {
//    agent any
//    stages {
//      stage('Checkout') {
//        steps {
//          //git url: 'https://github.com/getmahen/gojenkinslambda.git'
//          checkout scm
//          sh 'printenv'
//          echo "Running BUILD ID: ${env.BUILD_ID}"
//        }
//      }
//      stage('build') {
//        steps {
//          sh "echo Go path = ${env.GOPATH}"
//          sh 'go version'
//          sh 'make build'
//        }
//      }
//    }
//  }


///////VERSION 1 with Go Docker image/////////////////
//Simple Go Docker image
// pipeline {
//     agent {
//         docker { image 'pitchanon/jenkins-golang' }
//     }
//     stages {
//         stage('Golang version check and install dependencies') {
//             steps {
//                 sh 'go version'
//                 //sh 'apt-get install git'
//                 //sh 'USER root'
//                 //sh 'sudo usermod -aG docker Jenkins'
//                 //sh 'sudo usermod -aG root jenkins'
//                 //sh 'apk update && apk upgrade && apk add --no-cache bash git openssh && rm -rf /var/cache/apk/*'

//                 sh "GOROOT=${GOROOT}"
//                 sh "GOPATH=${GOPATH}"
//                 sh 'pwd'
//                 //sh 'chmod +x pwd()'
//                 sh 'ls -latr'
//                 sh 'go get github.com/golang/dep/cmd/dep'
//                 sh 'dep ensure -v'
//             }
//         }
//         stage('Run Unit tests') {
//             steps {
//                 sh 'make test'
//             }
//         }
//     }
// }



/////////////////VERSION 2 with Go Docker image - THIS WORKS UNTIL THE UNIT TEST POINT/////////////////
// pipeline {
//     agent any
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
//                     args '-v pwd:/go/src/gojenkinslambda -w /go/src/gojenkinslambda -e GRANT_SUDO=yes --user root'
//                 }
//             }
//             steps {
                
//                 sh 'go version'
                
//                 script {
//                     // You could split this up into multiple stages if you wanted to
//                     stage('Compile:Go') {
//                       sh 'ls -latr'
//                       sh 'go get -u github.com/golang/dep/...'

//                       //sh 'printenv'
//                       sh 'apt-get update'
//                       sh 'apt-get install -y zip'

//                       sh '''
//                       mkdir -p "$GOPATH/src/gojenkinslambda"
//                       cp . -r "$GOPATH/src/gojenkinslambda"
//                       cd "$GOPATH/src/gojenkinslambda"
//                       dep ensure -v
//                       ls -latr
//                       make test
//                       make build
//                       make package
//                       ls -latr ./checkipaddress
//                       '''
//                     }
//                 }
//             }
//         }
//     }
// }



///////////////VERSION 3 with Go Docker image - Works until Installing dependencies and looses context between stages/////////////////
// pipeline {
//     agent {
//         docker { 
//           image 'golang:1.9.2' 
//           // Use the same node as the rest of the build
//           reuseNode true
//           // Do go-platform stuff and put my app into the right directory
//           args '-v pwd:/go/src/gojenkinslambda -w /go/src/gojenkinslambda -e GRANT_SUDO=yes --user root'

//           customWorkspace "${env.GOPATH}/src/gojenkinslambda"
//         }
//     }
//     stages {
//         stage('checkout') {
//           steps {
//               git url: 'https://github.com/getmahen/gojenkinslambda.git'
//           }
//         }

//         stage('Checking Golang version....') {
//             steps {
//                 sh 'go version'
//             }
//         }

//         stage('Install dependencies and run unit tests...') {
//             steps {
//                 sh 'go get -u github.com/golang/dep/...'
//                 sh '''
//                   mkdir -p "$GOPATH/src/gojenkinslambda"
//                   cp . -r "$GOPATH/src/gojenkinslambda"
//                   cd "$GOPATH/src/gojenkinslambda"
//                   dep ensure -v
//                 '''
//             }
        
//         }
//         stage('Running Unit tests....') {
//             steps {
//                 sh 'cd "$GOPATH/src/gojenkinslambda"'
//                 sh 'ls -latr'
//                 sh 'make test'
//             }
//         }
//         stage('Builing artifacts....') {
//             steps {
//                 sh 'cd "$GOPATH/src/gojenkinslambda"'
//                 sh 'make build'
//             }
//         }
//         stage('Packaging artifacts....') {
//             steps {
//                 sh 'cd "$GOPATH/src/gojenkinslambda"'
//                 sh 'cd checkipaddress && zip -v checkipaddress.zip checkipaddress'
//                 sh 'ls -latr ./checkipaddress'
//             }
//         }
//     }
// }



///////////////VERSION 4 with Go Docker image - With Script{} to combine all stages/////////////////
pipeline {
    agent {
        docker { 
          image 'golang:1.9.2' 
          // Use the same node as the rest of the build
          reuseNode true
          // Do go-platform stuff and put my app into the right directory
          args '-v pwd:/go/src/gojenkinslambda -w /go/src/gojenkinslambda -e GRANT_SUDO=yes --user root'

          customWorkspace "${env.GOPATH}/src/gojenkinslambda"
        }
    }
    stages {
      stage ('Lambda build') {

        steps {
          script {

            stage('checkout') {
            steps {
                git url: 'https://github.com/getmahen/gojenkinslambda.git'
            }
          }

          stage('Checking Golang version....') {
              steps {
                  sh 'go version'
              }
          }

          stage('Install dependencies and run unit tests...') {
              steps {
                  sh 'go get -u github.com/golang/dep/...'
                  sh '''
                    mkdir -p "$GOPATH/src/gojenkinslambda"
                    cp . -r "$GOPATH/src/gojenkinslambda"
                    cd "$GOPATH/src/gojenkinslambda"
                    dep ensure -v
                  '''
              }
          
          }
          stage('Running Unit tests....') {
              steps {
                  sh 'cd "$GOPATH/src/gojenkinslambda"'
                  sh 'ls -latr'
                  sh 'make test'
              }
          }
          stage('Builing artifacts....') {
              steps {
                  sh 'cd "$GOPATH/src/gojenkinslambda"'
                  sh 'make build'
              }
          }
          stage('Packaging artifacts....') {
              steps {
                  sh 'cd "$GOPATH/src/gojenkinslambda"'
                  sh 'cd checkipaddress && zip -v checkipaddress.zip checkipaddress'
                  sh 'ls -latr ./checkipaddress'
              }
          }
          }
        }
    }
        
    }
}