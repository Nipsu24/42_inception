Name = inception

.DEFAULT_GOAL = all

CERT_DIR = ./srcs/requirements/nginx/tools/
CERT_KEY = $(CERT_DIR)/mmeier.42.fr.key
CERT_CRT = $(CERT_DIR)/mmeier.42.fr.crt
ENV_FILE = ./srcs/.env
DATA_DIR = /home/$(LOGIN)/data

all: check_env $(CERT_KEY) $(CERT_CRT)
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

fclean: down
	@echo "Removing data folder..."
	@rm -rf home/mmeier/data/
	@echo "Removing .env file..."
	@rm $(ENV_FILE)
	@echo ".env file removed."
	@echo "Data folder removed."

re: fclean all

.PHONY: all down env
