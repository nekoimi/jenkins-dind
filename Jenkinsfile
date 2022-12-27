#!/usr/bin/groovy

node {
    stage('Checkout') {
        checkout scm
    }

    stage('Build') {
        docker.withRegistry('https://index.docker.io/v1', 'dockerhub_access') {
            docker.build("nekoimi/jenkins-plus:latest").push()
        }
    }

    stage('Clean') {
        cleanWs()
    }
}
