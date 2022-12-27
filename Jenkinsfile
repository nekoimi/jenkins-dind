#!/usr/bin/groovy

node {
    def image = null

    stage('Checkout') {
        checkout scm
    }

    stage('Build') {
        image = docker.build("nekoimi/jenkins-plus:latest")
    }

    stage('Push') {
        docker.withRegistry('https://index.docker.io/v1', 'dockerhub_access') {
            image.push()
        }
    }

    stage('Clean') {
        cleanWs()
    }
}
