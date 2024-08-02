# 3-tier-Architecture-Deployment-across-Multiple-Environments
This is a comprehensive DevOps project demonstrating the deployment of the YelpCamp(3-tier architecture) application across various environments. The project includes setting up a three-tier deployment process covering local, containerized, and Azure Kubernetes Service (AKS) environments.

## Introduction

YelpCamp is a full-stack web application designed for campground reviews. This project focuses on setting up a robust deployment pipeline for YelpCamp, ensuring reliability, scalability, and maintainability across different environments.

## Features

- **Local Deployment:** Allows developers to test the application locally before pushing changes to other environments.
- **Container Deployment:** Utilizes Docker containers for development and testing, incorporating Jenkins pipelines for automated builds, tests, and scans.
- **Azure AKS Deployment:** Automates deployment to Azure Kubernetes Service (AKS) for production-level environments, ensuring seamless scalability and reliability.

## Architecture
![3-tier-deployment drawio (1)](https://github.com/user-attachments/assets/57e04ae0-7179-481f-a0fb-632e85f8d6c1)


## Project Structure
> **src** contains source code of yelpcamp including Dockerfile, Manifests file.

> **Terraform** consist instrastructure modular code. 

> **scripts** consist scripts to install tools on specific machine to reduce manual intervention.

## Tools and Technologies

- **Docker:** Containerization platform used for packaging the application and its dependencies.
- **Jenkins:** Automation server used for setting up continuous integration and continuous deployment (CI/CD) pipelines.
- **GitHub:** Version control system used for managing project source code and collaboration.
- **Terraform:** Infrastructure as code (IaC) tool used for provisioning and managing cloud infrastructure.
  > Modularized Code  |  Utilized workspace 
- **SonarQube:** Open-source platform for static code analysis to detect bugs, vulnerabilities, and code smells.
- **Trivy:** Vulnerability scanner for containers and other artifacts, used for scanning Docker images.


## Steps to Replicate the Project

### 1. **Project Setup**

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/vsingh55/3-tier-Architecture-Deployment-across-Multiple-Environments.git
   cd 3-tier-Architecture-Deployment-across-Multiple-Environments
   ```

2. **Put the values of environment variable and change .auto.tfvars files.**

### 2. **Infrastructure Provisioning**

1. **Install Required Tools:**
   - Terraform
   - kubectl
   - Azure CLI

2. **Initialize and Apply Terraform:**
   ```bash
   cd Terraform
   terraform init
   terraform workspace new dev
   terraform workspace select dev
   terraform apply -var-file=dev.auto.tfvars
   ```

### 3. **Set Up Jenkins Pipeline**

1. **Install Jenkins and Necessary Plugins.**

2. **Add Credentials for Docker Hub, SonarQube, and Kubernetes in Jenkins.**

3. **Create Jenkins Pipeline Job:**
   - Use the `Jenkinsfile` from the repository.

### 4. **Application Deployment**

1. **Prepare Kubernetes Manifests in the `Manifests` directory.**

2. **Create Namespace in AKS:**
   ```bash
   kubectl create namespace webapps
   ```

3. **Run Jenkins Pipeline to Deploy Docker Image to AKS.**



### 8. **Cleanup**

1. **Destroy Infrastructure:**
   ```bash
   terraform destroy -var-file=<name_of_environment>.auto.tfvars
   ```

2. **Remove Unused Resources.**

For detailed instructions, please refer to [this blog post](https://blogs.vijaysingh.cloud/deploy-trio).

---

<!-- ## Skills Gained

By working on the this project, you will gain valuable experience in:

- Setting up CI/CD pipelines using Jenkins.
- Containerizing applications with Docker.
- Conducting static code analysis and vulnerability scanning.
- Deploying applications to Azure Kubernetes Service (AKS).
- Infrastructure as code (IaC) using Terraform. -->

## Contribution

Contributions to the this project are **Welcome!** If you encounter any issues or have suggestions for improvement, feel free to open an issue or submit a pull request.

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgements

- This project was inspired by the need for a robust deployment pipeline for YelpCamp.
- Special thanks to the contributors and maintainers of the tools and technologies used in this project.
- Media management provided by **Cloudinary**.
- Maps integration provided by **Mapbox**.
---