# chef-rabbitmq-no-dependency

# how to run this

## start a container
```
docker run -d chef/chefdk sleep 99999
```
## run it
To run the cookbook, go into the container, create a folder in root, git clone this repo
```
docker exec -it [container_id] /bin/bash
mkdir cookbooks;cd cookbooks
git clone https://github.com/lianxingye/chef-rabbitmq-no-dependency.git
chef-client -z -o chef-rabbitmq-no-dependency
```

# details about how to test rabbitmq

https://www.rabbitmq.com/tutorials/tutorial-one-python.html
