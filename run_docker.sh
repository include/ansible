docker run -e AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY_ID}"         \
           -e AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}" \
           -e EC2_REGION="${EC2_REGION}"                       \
           -e ANSIBLE_HOSTS="./inventories/ec2.py"             \
           -e EC2_INIT_PATH="./inventories/ec2.ini"            \
           -v ~/.ssh:/root/.ssh                                \
           -ti include/ansible /bin/bash
