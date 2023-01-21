node {
    stage('continuousDownload')
    {
        git 'https://github.com/MRaju2022/maven.git'
    }
    stage('continuousBuild')
    {
        sh 'mvn package'
    }
    stage('continuousDeployment')
    {
        sh 'scp /home/ubuntu/.jenkins/workspace/ScriptedProject/webapp/target/webapp.war ubuntu@172.31.24.179:/var/lib/tomcat9/webapps/testenv.war'
    }
    stage('continuousTesting')
    {
        git 'https://github.com/MRaju2022/Testing.git'
        sh 'java -jar /home/ubuntu/.jenkins/workspace/ScriptedProject/testing.jar'
    }
    stage('continuousDelivery')
    {
         sh 'scp /home/ubuntu/.jenkins/workspace/ScriptedProject/webapp/target/webapp.war ubuntu@172.31.21.17:/var/lib/tomcat9/webapps/prodenv.war'
    }
}


// This change to practice git pull command

//Build practice



//13-09-2022 modified


//01-10-2022 Jenkins pipeline


//08-12-2022 I am trying to understand git merge

