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
        stage("Docker build and push") {
            steps {
                sh "docker build -t docker-registry:5000/calculator ."
                sh "docker push docker-registry:5000/calculator"
            }
        }
        stage("Deploy to staging") {
            steps {
                sh "docker run  -d --rm -p 8765:8080 --name calculator docker-registry:5000/calculator"
            }
        }
        stage("Acceptance test") {
            steps {
                sleep 60
                sh "chmod +x acceptance_test.sh && ./acceptance_test.sh"
            }
        }
    }
    post {
        always {
            sh "docker stop calculator"
        }
    }
}
