

## Run Gollum
```
docker run -v $(pwd):/apps gollum:latest
```

## Run Nginx
```
docker run -v $(pwd)/conf/nginx:/etc/nginx -v 
```


```
sudo docker run -it --rm --name certbot \
            -v "/etc/letsencrypt:/etc/letsencrypt" \
            -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
            certbot/certbot certonly
```