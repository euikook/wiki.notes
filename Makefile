TOP_DIR=$(PWD)

gollum:
	docker run -it --rm --name gollum \
		-v $(TOP_DIR):/apps \
		euikook/gollum-unicorn

gollum.build:
	docker build -t euikook/gollum-unicorn .

webroot:
	docker run --rm --name webroot \
		-v $(TOP_DIR)/var/www/certbot:/var/www/certbot \
		-v $(TOP_DIR)/conf/nginx/certbot.conf:/etc/nginx/conf.d/default.conf \
		-p 80:80 \
		nginx

nginx: 
	docker run -d --rm --name nginx \
		-v $(TOP_DIR):/apps \
		-v "$(TOP_DIR)/conf/certbot:/etc/letsencrypt" \
		-v "$(TOP_DIR)/var/certbot:/var/lib/letsencrypt" \
		-v $(TOP_DIR)/conf/nginx/nginx.conf:/etc/nginx/conf.d/default.conf \
		-p 80:80 \
		-p 443:443 \
		nginx

certbot:
	docker run -it --rm --name certbot \
		-v "$(TOP_DIR)/var/www/certbot:/var/www/certbot" \
		-v "$(TOP_DIR)/conf/certbot:/etc/letsencrypt" \
		-v "$(TOP_DIR)/var/certbot:/var/lib/letsencrypt" \
		certbot/certbot certonly --webroot -w /var/www/certbot -d acme.com
