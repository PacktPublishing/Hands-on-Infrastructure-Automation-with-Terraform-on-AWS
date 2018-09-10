#!/bin/env bash

set -euo pipefail
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting user data..."

echo ECS_CLUSTER=${ecs_cluster_name}  >> /etc/ecs/ecs.config

touch /home/ec2-user/success
echo "All done"