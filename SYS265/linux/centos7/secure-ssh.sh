#secure-ssh.sh
#author jeffreyhill8
#creates a new ssh user using $1 parameter
#adds a public key from the local repo or curled from the remote repo
#removes roots ability to ssh in

#!/bin/bash

# echo "Script is Running"
if [ -z "$1" ]; then
  echo "Usage: $0 <username>"
  exit 1
fi

USERNAME="$1"

sudo useradd -m -s /bin/bash $USERNAME
# echo "The value of USERNAME is $USERNAME"

sudo mkdir -p /home/$USERNAME/.ssh
# echo "The directory /home/$USERNAME/.ssh was created"

sudo touch /home/$USERNAME/.ssh/authorized_keys

sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
sudo chmod 700 /home/$USERNAME/.ssh
sudo chmod 600 /home/$USERNAME/.ssh/authorized_keys

PUBLIC_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC+xSNaHU5FYrzRM/AssXqCaIhywjw30QpQy37SgL6GJQPpI7uOGmIPGsWYWKSOmU/jx8l1BXF3SnLK7S8TJgF9xxI8AueISYb+lkabMg+qkAJ/X+i9P/Uq+4jF2APhJwdcv4aLQI0k68U5DdyPgiyq4ctAePOkAvWxtPtkS2wGctN3m5HOCcWqjYqciDS8vE30/eFzJ5oZJxvLQHLmUxZKbxuyH7KqP7AyUkIDiu99pdQ5XZWUoGcX5wMgCakZt0l96Vz6HNkHn2V2mvCT5pvizJpsJ17unzWMApK0kXEDZ57xBqmIfbmsWjnCPy9F6Y39LzRxnlsQeZaSgEBHteGj7GJjtqLuUf0o78AcjNOUE54EVBkG814StA1YTftpCgXEr9muq1BkmQgmZsHOZ73SbJCeUrAI4MLjYJXsRTgyfRL4eQza3gDBAlu5ryGOitZBB/97nKO5MK7iWqLtn/7swwf1upY4LiZIWQK7uKFgQ0Mj2hOLvSs9HVMqqVirE68= sys265"
echo $PUBLIC_KEY >> /home/$USERNAME/.ssh/authorized_keys

sudo sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config

sudo systemctl restart sshd
