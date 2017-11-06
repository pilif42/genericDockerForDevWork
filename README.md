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


- to start containers in the background:
docker-compose -f docker-compose-dev_env.yml up -d  


- to verify RabbitMQ is up and running:
	- http://localhost:16672/#/ with guest / guest


