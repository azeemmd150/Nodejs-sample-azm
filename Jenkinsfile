
def branchAndBuildTag() {
    return "${env.BRANCH_NAME}${env.BUILD_NUMBER}"
}


def getBuildNum() {
     return "${env.BUILD_NUMBER}"
}


node() {
    
    stage('checkout'){
        // checkout([$class: 'GitSCM', branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/kps25/ssp-nodejs-k8s-latest.git']]])
        checkout scm
    }
     
    stage("Build Docker Image"){
        sh "docker build -t azm:${branchAndBuildTag()} ."
        sh "docker images"
    }
}