properties([
  parameters([
  [
      $class: 'ChoiceParameter',
      choiceType: 'PT_SINGLE_SELECT',
      name: 'PACKER_VERSION',
      script: [
        $class: 'GroovyScript',
        script: [
          classpath: [],
          sandbox: false,
          script: """
import jenkins.model.*
import jenkins.*
import groovy.json.JsonSlurper

// define website to collect releases
def owner = "hashicorp"
def repo = "packer"
def apiUrl = "https://api.github.com/repos/\${owner}/\${repo}/releases"

// send a curl command and collect the results
def process = "curl -s \${apiUrl}".execute()
def response = process.text

def jsonSlurper = new JsonSlurper()
def releases = jsonSlurper.parseText(response)
def tags = []

// if releases were found then return their tags
// if not return error
if (releases) {
    tags = releases.collect { it.tag_name }
} else {
    return [Error]
}

return tags
    """
    ]
   ]
  ]
])
])
           
pipeline {
  agent {
    kubernetes {
yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    purpose: echimp-cd-helm-pipeline
spec:
  restartPolicy: Never
  containers:
  ###########################################################################################
  # For AWS CLI execution
  ###########################################################################################
  - name: kaniko
    image: gcr.io/kaniko-project/executor:debug
    imagePullPolicy: Always
    command: ['cat']
    tty: true
    env:
    - name: container
      value: "docker"
    volumeMounts:
      - name: jenkins-docker-cfg
        mountPath: /kaniko/.docker
  volumes:
  - name: jenkins-docker-cfg
    emptyDir:
      sizeLimit: 1G        
      """
    }
  }
  environment {
    HARBOR_URL = 'harbor.10.0.0.127.nip.io:30003'
    HARBOR_PROJECT_NAME = 'builds'
    HARBOR_PACKER_REPO_LOCAL = 'packer'
  }  

  stages {
    stage ('packer'){
      steps {     
        script {
          container('kaniko'){
            // tag the helm chart with the chosen docker image
            withCredentials([usernamePassword(credentialsId: 'harbor-cred', usernameVariable: 'HARBOR_USERNAME', passwordVariable: 'HARBOR_PASSWORD')]) {
              sh """
                #packer_version=\$(echo ${params.PACKER_VERSION} |cut -dv -f2)
                #echo "{\\"auths\\":{\\"${HARBOR_URL}\\":{\\"username\\":\\"${HARBOR_USERNAME}\\",\\"password\\":\\"${HARBOR_PASSWORD}\\"},\\"index.docker.io\\":{\\"auth\\":\\"YWRtaW46SGFyYm9yMTIzNDU=\\"}}}" > /kaniko/.docker/config.json
                echo -n "{\\"auths\\":{\\"https://index.docker.io/v1/\\":{\\"auth\\":\\"\$(echo -n martinlourduswamy:Kandikuppam@123 | base64)\\"}}}" > /kaniko/.docker/config.json
                cat /kaniko/.docker/config.json
                #/kaniko/executor -f `pwd`/Dockerfile -c `pwd` --insecure --skip-tls-verify --cache=false --destination=${HARBOR_URL}/${HARBOR_PROJECT_NAME}/mag-tools:latest
                /kaniko/executor -f `pwd`/Dockerfile -c `pwd` --insecure --skip-tls-verify --cache=false --destination=martinlourduswamy/mag-tools:latest
              """
            }
          }
        }
      }
    }
  }
}
