This work was done with Docker Community Edition Version 17.09.0-ce-mac35 (19611) on a Mac OS X El Capitan.


- In our docker-compose-dev_env.yml, we define all the services that we need for our development work. For instance, rather than installing RabbitMQ locally, we will just run it inside a container. This helps be efficient quickly.
	- Notes on the ports section:
		- for some mappings, we use variables. ${EX_REDIS_PORT} for instance. These variables are being pickep up from the file .env at the root of the project.
		- on the left-hand side, this is the port value at which the local Mac sees the service. For instance, if we start containers on my local Mac, I will have to open Chrome at http://localhost:16672/#/ to view the RabbitMQ console.
		- on the right-hand side, this is the port value at which the service is running inside the container. For instance, RabbitMQ console is at 15672 inside the container, which is the default value.

	- Notes on the RabbitMQ service:
		- by default, the RabbitMQ web console runs on 15672 (http://localhost:15672/#/) and you can log in with guest / guest. This is what I used when installing RabbitMQ locally. My notes for this local set up are below:
				- RabbitMQ directory: cd /usr/local/sbin
					- in rabbitmq-env, I changed the port value from default 5672 to 6672.
				- check status: ./rabbitmqctl status
				- stop the service: ./rabbitmqctl stop
						- verify http://localhost:15672/#/ is down
				- start the service: ./rabbitmq-server
						- verify http://localhost:15672/#/ is up
				- to reset RabbitMQ to a virgin state:
						- ./rabbitmqctl stop_app
						- ./rabbitmqctl force_reset
						- ./rabbitmqctl start_app
						- verify http://localhost:15672/#/ for exchanges, queues
				- to post a message manually, add properties below:
						- delivery_mode: 2
						- content_type: text/xml
						- Encoding: string
		- when running with Docker, note that I mapped 15672 to 16672. So, the console is at http://localhost:16672/#/


- to view running containers:
docker ps


- to view all containers:
docker ps -a


- to delete a specific container:
docker stop <CONTAINER_NAME>
docker rm <CONTAINER_NAME>


- to create & start containers in the background:
docker-compose -f docker-compose-dev_env.yml up -d  


- to stop and remove all containers:
docker-compose -f docker-compose-dev_env.yml down  


- to stop all containers but not removing them:
docker stop $(docker ps -q)


- to start all containers:
docker start $(docker ps -a -q)


- to verify RabbitMQ is up and running:
	- http://localhost:16672/#/ with guest / guest


- to verify the sftp server is up and running:
	- open a Terminal
	- sftp -P 122 centos@localhost
			- 122 is the port value ${EX_SFTP_PORT} defined in .env
			- centos is the user defined in docker-compose-dev_env.yml
			- localhost or <host-ip> of the Mac onto which I started containers
	- You then get presented with:
			The authenticity of host '[localhost]:122 ([127.0.0.1]:122)' can't be established.
			ED25519 key fingerprint is SHA256:vFTS6LbVlo8V9blmaIy9brByV0w0adTp0liUxBtslIc.
			Are you sure you want to continue connecting (yes/no)? yes
			Warning: Permanently added '[localhost]:122' (ED25519) to the list of known hosts.
			centos@localhost's password: 
	- After entering the password defined in docker-compose-dev_env.yml, you get presented with:
			Connected to localhost.
			sftp> 

			- If instead, you get: WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!, IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
					- stop and remove containers
					- cd /Users/philippebrossier/.ssh/
					- vi known_hosts
					- remove the line starting [localhost]:122
					- restart containers
