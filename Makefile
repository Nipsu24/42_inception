Name = inception

.DEFAULT_GOAL = all

CERT_DIR = ./srcs/requirements/nginx/tools/
CERT_KEY = $(CERT_DIR)/mmeier.42.fr.key
CERT_CRT = $(CERT_DIR)/mmeier.42.fr.crt
ENV_FILE = ./srcs/.env
DATA_DIR = /home/$(LOGIN)/data

all: check_env $(CERT_KEY) $(CERT_CRT)
	@mkdir -p ~/data/mariadb
	@mkdir -p ~/data/wordpress
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

check_env: env
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "Error: .env file is missing. Please create it using 'make env'."; \
		exit 1; \
	fi

env:
	./create_env.sh

$(CERT_KEY) $(CERT_CRT):
	@mkdir -p $(CERT_DIR)
	@openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout $(CERT_KEY) \
		-out $(CERT_CRT) \
		-subj "/C=FI/ST=/L=Helsinki/O=Hive/OU=42/CN=mmeier.42.fr/UID=mmeier"

down:
	@docker-compose -f ./srcs/docker-compose.yml down

fclean:
	@echo "Removing containers, networks and volumes..."
	@docker-compose -f ./srcs/docker-compose.yml down -v
	@echo "Removing data folder..."
	@sudo rm -rf ~/data
	@if [ -f $(ENV_FILE) ]; then \
        	echo "Deleting .env file..."; \
        	rm -f $(ENV_FILE); \
		echo ".env file removed"; \
    	else \
        	echo ".env file does not exist, skipping..."; \
    	fi	
	@echo "Data folder removed."

re: fclean all

.PHONY: all down env
