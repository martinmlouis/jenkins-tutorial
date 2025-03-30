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
import groovy.json.JsonSlurper
import jenkins.model.*

// define website to collect releases
def owner = "hashicorp"
def repo = "packer"
def apiUrl = "https://api.github.com/repos/hashicorp/packer/releases"

// send a curl command and collect the results
def process = "curl -s https://api.github.com/repos/hashicorp/packer/releases".execute()
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
      yaml '''
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            some-label: some-label-value
        spec:
          containers:
          - name: maven
            image: maven:3.9.9-eclipse-temurin-17
            command:
            - cat
            tty: true
          - name: busybox
            image: busybox
            command:
            - cat
            tty: true
        '''
    }
  }
  stages {
    stage ('maven'){
      steps {     
        script {
          container('maven'){
            sh """
              mvn --version
            """
          }
        }
      }
    }
  }
}
