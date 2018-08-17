#!/bin/env bash

set -euo pipefail
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting user data..."
yum update -y
yum install -y postgresql96.x86_64
touch /home/ec2-user/success
echo "All done"