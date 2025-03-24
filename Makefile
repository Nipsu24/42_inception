Name = inception

.DEFAULT_GOAL = all

CERT_DIR = ./srcs/requirements/nginx/tools/
CERT_KEY = $(CERT_DIR)/mmeier.42.fr.key
CERT_CRT = $(CERT_DIR)/mmeier.42.fr.crt

all: $(CERT_KEY) $(CERT_CRT)
	@docker-compose -f ./srcs/docker-compose.yml up -d --build

$(CERT_KEY) $(CERT_CRT):
	@mkdir -p $(CERT_DIR)
	@openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout $(CERT_KEY) \
		-out $(CERT_CRT) \
		-subj "/C=FI/ST=/L=Helsinki/O=Hive/OU=42/CN=mmeier.42.fr/UID=mmeier"

down:
	@docker-compose -f ./srcs/docker-compose.yml down

.PHONY: all down
