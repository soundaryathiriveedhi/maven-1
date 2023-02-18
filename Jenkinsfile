// node 
// {
//     stage('ContinuousDownload') 
//     {
//        git 'https://github.com/MRaju2022/maven.git'
//     }
//     stage('ContinuousBuild') 
//     {
//        sh 'mvn package'
//     }
//      stage('ContinuousDeployment') 
//     {
//       sh 'scp /home/ubuntu/.jenkins/workspace/scriptedPipeline/webapp/target/webapp.war  ubuntu@172.31.7.171:/var/lib/tomcat9/webapps/testenv.war'
//     }
//      stage('ContinuousTesting') 
//     {
//        git 'https://github.com/MRaju2022/Testing.git'
//        sh 'java -jar /home/ubuntu/.jenkins/workspace/scriptedPipeline/testing.jar'
//     }
//     stage('ContinuousDelivery') 
//     {
//        sh 'scp /home/ubuntu/.jenkins/workspace/scriptedPipeline/webapp/target/webapp.war  ubuntu@172.31.6.98:/var/lib/tomcat9/webapps/prodenv.war'
//     }
    
// }

//  pipeline{
// 	agent any
// 	environment {
// 		PATH = "$PATH:/opt/apache-maven-3.6.3/bin"
//         }
// 	stages{
// 		stage('DownloadCode'){
// 			steps{
// 				git "https://github.com/MRaju2022/maven.git"
// 			}
// 		}
// 		stage('Build'){
// 			steps{
// 				sh 'mvn clean package'
// 			}
// 		}
// 		stage('SonarQube Analysis'){
// 			steps{
// 				withSonarQubeEnv('Sonar-Server-7.8'){
// 					sh "mvn sonar:sonar"
// 				}
// 			}

// 		}
// 		stage('Deployment'){
// 		 steps{
// 		     sshagent(['Tomcat-Server-Agent']) {
//                 sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/My-Pipeline-Job/webapp/target/webapp.war ec2-user@13.233.151.160:/home/ec2-user/apache-tomcat-10.0.27/webapps'
//             }
		     
// 		 }   
// 		}
// 		}
// 	}


// pipeline {
//     agent any
    
//     environment {
//         PATH = "$PATH:/opt/apache-maven-3.6.3/bin"
//     }

//     stages {
//         stage('ContinuousDownload') {
//             steps {
//                 git "https://github.com/MRaju2022/maven.git"
//             }
//         }
        
//         stage('ContinuousBuild'){
//             steps{
                
//                 sh 'mvn clean package'
//             }
//         }
        
//         stage('SonarQubeAnalysis'){
//             steps{
//                 withSonarQubeEnv('Sonar-Server-7.8') {
//                     sh 'mvn sonar:sonar'
//                 }
//             }
//         }
//         stage('ContinuousDeploy'){
//             steps{
//                 sshagent(['Tomcat-Server-Agent']) {
//                   sh 'scp -o StrictHostKeyChecking=no webapp/target/webapp.war ec2-user@52.66.240.200:/home/ec2-user/apache-tomcat-10.0.27/webapps'
//                 }
//             }
//         }
//     }
// }


node{
	stage('git clone'){
		
         git credentialsId: 'bd578fe5-d88f-4cdd-b9ef-96fa3ee294a2', url: 'https://github.com/MRaju2022/maven.git'
	
        }
    stage('clean and package'){
        
        def mavenHome = tool name: "Maven-3.8.6", type: "maven"

        def mavenCMD = "${mavenHome}/bin/mvn"
        
        sh "${mavenCMD} clean package"
    }
    
    stage('code review'){
        withSonarQubeEnv('Sonar-Server-7.8'){
            def mavenHome = tool name: "Maven-3.8.6", type: "maven"
            def mavenCMD = "${mavenHome}/bin/mvn"
            sh "${mavenCMD} sonar:sonar"
        }
    }
    
    
    stage('build docker image'){
        sh  'docker build -t mraju25/mavenwebapplication .'
    }
    stage('Push Image'){
        
      withCredentials([string(credentialsId: 'DOCKER_CREDENTIALS1', variable: 'DOCKER_CREDENTIALS')]) {
          sh 'docker login -u mraju25 -p ${DOCKER_CREDENTIALS}'
      }
     
       sh 'docker push mraju25/mavenwebapplication'
     
    }
    
    stage('app deploy'){
        kubernetesDeploy(
            configs: 'maven-web-app-deploy.yml',
            kubeconfigId: 'K8S-CONFIGURATION'
            )
    }

}
