# mysite_nginx.conf

# Gunicorn server
upstream django {
  server         web:8000;
}

# configuration of the server
server {
    listen 8080;
#   server_name *.continity.io;

    # max upload size
    client_max_body_size 100M;   # adjust to taste

    location /static/ {
        alias /var/www/django/static;
    }

    # Django media
    location /media/ {
        alias /var/www/django/media;
    }

    location / {
        proxy_pass http://django;
        proxy_redirect     off;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
    
    error_log /var/log/nginx/django_error.log;
    access_log /var/log/nginx/django_access.log;
}
