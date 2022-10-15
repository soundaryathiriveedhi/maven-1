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

 pipeline{
	agent any
	environment {
		PATH = "$PATH:/opt/apache-maven-3.6.3/bin"
        }
	stages{
		stage('DownloadCode'){
			steps{
				git "https://github.com/MRaju2022/maven.git"
			}
		}
		stage('Build'){
			steps{
				sh 'mvn clean package'
			}
		}
		stage('SonarQube Analysis'){
			steps{
				withSonarQubeEnv('Sonar-Server-7.8'){
					sh "mvn sonar:sonar"
				}
			}

		}
		stage('Deployment'){
		 steps{
		     sshagent(['Tomcat-Server-Agent']) {
                sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/My-Pipeline-Job/webapp/target/webapp.war ec2-user@13.233.151.160:/home/ec2-user/apache-tomcat-10.0.27/webapps'
            }
		     
		 }   
		}
		}
	}

