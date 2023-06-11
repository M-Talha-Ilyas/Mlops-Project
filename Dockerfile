pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                // Checkout source code from your GitHub repository
                git 'https://github.com/yourusername/your-repo.git'

                // Build the Docker image
                script {
                    docker.withRegistry('https://registry.example.com', 'docker-credentials-id') {
                        def customImage = docker.build('your-image-name')

                        // Optionally, you can tag the image
                        customImage.tag('your-image-name:latest')
                    }
                }
            }
        }

        stage('Publish Docker Image') {
            steps {
                // Push the Docker image to the registry
                script {
                    docker.withRegistry('https://registry.example.com', 'docker-credentials-id') {
                        def customImage = docker.image('your-image-name')

                        // Push the image to the registry
                        customImage.push('latest')
                    }
                }
            }
        }
    }
}
