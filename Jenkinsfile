//this is a test
pipeline{
    agent any
    tools {
        maven 'maven'
    }
    environment {
        DOCKER_TAG = getVersion()
    }
    stages{
        stage('SCM CHECKOUT'){
            steps{
            git branch: 'master', 
                url: 'https://github.com/dileep208/dockeransible.git'
            }
        }

        stage('MAVEN BUILD'){
            steps{
            sh 'mvn clean package'
            }
        }

        stage('DOCKER BUILD'){
            steps{
                sh "docker build . -t dileepugrangi/dileepapp1:${DOCKER_TAG}"

            }
        }

        stage('DOCKER PUSH'){
            steps{
                withCredentials([string(credentialsId: 'DOCKER_SECRET', variable: 'dockerHubPwd')]) {
                    sh "docker login -u dileepugrangi -p ${dockerHubPwd}"
            }
            sh "docker push dileepugrangi/dileepapp1:${DOCKER_TAG}"
                
            }
        }

        stage('DOCKER DEPLOY'){
            steps{
                ansiblePlaybook credentialsId: 'JENKINS_LOCALHOST', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${DOCKER_TAG}", installation: 'ansible', inventory: 'dev.inv', playbook: 'dockeransible.yaml'
            }
        }
    }
}

def getVersion(){
    def commitHash = sh label: '', returnStdout: true, script: 'git rev-parse --short HEAD'
    return commitHash
}
