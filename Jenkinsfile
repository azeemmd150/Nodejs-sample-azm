node() {

def dockerImg = "azeemmd03/nodejssample"
    
stage('checkout') {
        //checkout([$class: 'GitSCM', branches: [[name: "*/${BRANCH_NAME}"]], extensions: [], userRemoteConfigs: [[url: 'https://github.com/azeemmd150/Nodejs-sample-azm.git']]])
        checkout scm
     
    }
stage("Build Docker Image"){
        sh "docker build -t $dockerImg:azm$BUILD_NUMBER ."
    }
     stage("Docker Push"){
      withCredentials([string(credentialsId: 'DOCKER_HUB_CREDENTIALS', variable: 'DOCKER_HUB_CREDENTIALS')]) {
         sh "docker login -u azeemmd03 -p ${DOCKER_HUB_CREDENTIALS}"
     }
        sh "docker push $dockerImg:azm$BUILD_NUMBER "  
  }
   // stage("Docker Push"){
     //   withCredentials([string(credentialsId: 'ssp25dockertoken', variable: 'dockercreds')]) {
      //      sh " echo ${dockercreds} | docker login -u ssp25 --password-stdin "
     //   }    
    //    sh "docker push $dockerImg:azm$BUILD_NUMBER " 
   // }

    stage('Deploy k8s'){
       withCredentials([kubeconfigFile(credentialsId: 'azmk8s', variable: 'KUBECONFIG')]) {
          //  docker.image('jshimko/kube-tools-aws:latest').inside("-u root") {
               sh """
                    cd $WORKSPACE
                    echo 'Deployiong the docker image'
                    sed "s/buildNum/azm$BUILD_NUMBER/g" ./k8s/deploy.yaml | kubectl apply --namespace "${BRANCH_NAME}" -f -
                 """
            
        }
    }
}

