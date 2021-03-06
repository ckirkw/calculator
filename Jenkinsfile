pipeline {
    agent any
    stages {
        stage("Compile") {
            steps {
                sh "mvn -B -DskipTests clean package"
            }
        }
        stage("Unit test") {
            steps {
                sh "mvn test"
            }
        }
        stage("SonarQube analysis") {
            steps {
              withSonarQubeEnv("SonarQube") {
                sh "mvn sonar:sonar"
              }
            }
        }
        stage("Quality gate") {
            steps {
              waitForQualityGate abortPipeline: true
            }
        }
    }
}
