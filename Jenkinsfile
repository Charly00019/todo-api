pipeline {
    agent {
        label 'Job-Runner'  // Uses your specified agent
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Clone your GitHub repository
                git branch: 'main',  // Change to your branch name
                     url: 'https://github.com/your-username/your-repo.git'  // Update with your repo URL
                
                // Verify the repository was cloned
                sh 'ls -la'
            }
        }
        
        stage('Display README') {
            steps {
                // Check if README exists and display it
                script {
                    if (fileExists('README.md')) {
                        echo "Contents of README.md:"
                        sh 'cat README.md'
                    } else {
                        error "README.md not found in the repository root"
                    }
                }
            }
        }
    }
    
    post {
        always {
            echo "Pipeline completed on agent: ${env.NODE_NAME}"
            cleanWs()  // Optional: Clean the workspace after build
        }
    }
}
