#!/usr/bin/groovy

node {
    stage('Checkout') {
        checkout scm
    }

    stage('Build') {
        docker.withRegistry('', 'dockerhub_access') {
            docker.build("nekoimi/jenkins-plus:latest").push()
        }
    }

    stage('Clean') {
        cleanWs()
    }
}
