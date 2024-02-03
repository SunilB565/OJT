#!/bin/bash

# AWS CLI command to list AMIs with the specified name pattern
ami_list=$(aws ec2 describe-images --filters "Name=name,Values=ojt*" --query 'Images | sort_by(@, &CreationDate) | [-1]' --output json)

# Extract the AMI ID from the result
ami_id=$(echo $ami_list | jq -r '.ImageId')

# Print the AMI ID
echo $ami_id
