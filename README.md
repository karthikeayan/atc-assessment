# atc-assessment

Below steps works on Mac and Linux

Clone the Git Repo
```
git clone https://github.com/karthikeayan/atc-assessment
```

There are three different directories in this repository.
1. provisioning - Terraform code to create the EKS cluster and its supported resources in AWS including VPC and subnet
2. application - Simple NodeJS Web Application which responds the HTML page prints the values of ATC_USERNAME and ATC_PASSWORD Environment variables
3. kubernetes - Application deployment YAML files

## Architecture
![alt text](https://github.com/karthikeayan/atc-assessment/blob/main/architecture.png?raw=true)

## Provisioning

- Go to provisioning directory
```
cd provisioning
```

- Set AWS Account credentials for Terraform
```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
```

- Create EKS cluster with Terraform
```
terraform init
terraform plan
terraform apply
```

This will create the EKS cluster

## Application

- Go back to previous directory
```
cd ..
```

- Go to application directory
```
cd application
```

- Create docker image and push it to AWS ECR
    - In case if you are not using "docker" CLI, please replace "docker" with your CLI
    - Update Docker image version when you have new major version, typically this will be handled in CI
    - Replace 402105302200 with your AWS Account ID
```
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 402105302200.dkr.ecr.us-east-1.amazonaws.com
docker build -t atc-node-app .
docker tag atc-node-app:latest 402105302200.dkr.ecr.us-east-1.amazonaws.com/atc-node-app:1.0.0
docker push 402105302200.dkr.ecr.us-east-1.amazonaws.com/atc-node-app:1.0.0
```

## Kubernetes

- Get kubeconfig to connect to the EKS Cluster
```
aws eks update-kubeconfig --name atc-assessment --region us-east-1
```

- Create deployments in EKS to run the application, replace "<YOUR_AWS_ACCOUNT_ID>" with your AWS Account ID
```
cd ..
sed -i 's/402105302200/<YOUR_AWS_ACCOUNT_ID>/' kubernetes/atc-node-app.yaml
kubectl apply -f kubernetes/
```

- Wait for 2 minutes, Get the load balancer hostname
```
kubectl get service | grep atc-node-app | awk '{print $4}'
```

- Access the ALB URL in browser
```
http://<OUTPUT_FROM_PREVIOUS_COMMAND>