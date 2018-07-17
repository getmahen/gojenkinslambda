#!/usr/bin/env groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building'
                sh 'make build'
                sh 'ls -la'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing'
                sh 'make test'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying'
            }
        }
    }
}