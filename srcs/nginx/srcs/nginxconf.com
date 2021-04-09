user                            www;
worker_processes                auto; # it will be determinate automatically by the number of core

error_log                       /var/log/nginx/error.log warn;
#pid                             /var/run/nginx/nginx.pid; # it permit you to use /etc/init.d/nginx reload|restart|stop|start

events {
    worker_connections          1024;
}

http {
    include                     /etc/nginx/mime.types;
    default_type                application/octet-stream;
    sendfile                    on;
    access_log                  /var/log/nginx/access.log;
    keepalive_timeout           3000;
    server {
        listen                  80;
        root                    /www;
        index                   index.html;
        server_name             _;
        client_max_body_size    32m;

        return 301 https://$host$request_uri;

    }
    server {
        listen 443 ssl;
        root                    /www;
        server_name             _;
        index                   index.html;
    	ssl_certificate         /root/mkcert/localhost.pem;
    	ssl_certificate_key     /root/mkcert/localhost-key.pem;

        error_page              500 502 503 504  /50x.html;

        location = /50x.html {
                      root              /var/lib/nginx/html;
                }

        location /phpmyadmin/ {
                    index               index.php;
                    proxy_pass          https://phpmyadmin-service:5000/;
                    proxy_set_header    Host $http_host;
                    proxy_set_header    X-Real-IP $remote_addr;
                    proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
                    proxy_set_header    X-Forwarded-Proto $scheme;
                    proxy_redirect / /phpmyadmin/;
                }
        location /wordpress {
                    	return 307 https://$host:5050/;
                	}
}
}