pipeline {
    agent { label 'ansible-agent' }  // Replace with your agent label
 
    stages {
        stage('Clone The Repo') {
            steps {
                // Checkout your repository containing the Ansible playbooks
                git url: 'https://github.com/belalelnady/DEPI-Graduation-Project-Automated-Deployment-Pipeline', branch: 'master' // Replace with your repo URL and branch
            }
        }
        stage('Run Ansible Playbook') {
            steps {
                script {
                    // Run the Ansible command
                    sh 'ansible-playbook -i ./inventory.ini install-docker.yml' // Replace with your playbook and inventory files
                }
            }
        }
    }
    post {
        success {
            echo 'Ansible playbook executed successfully!'
        }
        failure {
            echo 'Ansible playbook execution failed.'
        }
    }
}
