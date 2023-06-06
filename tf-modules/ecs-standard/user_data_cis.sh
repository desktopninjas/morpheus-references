#!/bin/bash

# Install necessary packages
yum update -y
yum install -y aws-cfn-bootstrap awscli

# Create ECS config
echo "ECS_CLUSTER=${cluster_name}" >> /etc/ecs/ecs.config
echo "ECS_BACKEND_HOST=" >> /etc/ecs/ecs.config

# Add the ecsInstanceRole to the instance
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s 169.254.169.254/latest/dynamic/instance-identity/document | jq -r .region)
aws ec2 associate-iam-instance-profile --instance-id $INSTANCE_ID --iam-instance-profile Name=ecsInstanceRole --region $REGION

# Start ECS agent
service docker start
start ecs

# Hardening script location
CIS_HARDENING_SCRIPT_URL=${cis_hardening_script}

# Download and run hardening script
curl -o /tmp/cis-hardening-script.sh $CIS_HARDENING_SCRIPT_URL
chmod +x /tmp/cis-hardening-script.sh
/tmp/cis-hardening-script.sh

# Signal CloudFormation that setup is complete
/opt/aws/bin/cfn-signal -e $? --stack ${AWS::StackName} --resource AutoScalingGroup --region ${AWS::Region}