user                            www;
worker_processes                auto; # it will be determinate automatically by the number of core
pid                             /var/run/nginx.pid;
error_log                       /var/log/nginx/error.log warn;

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
        root                    /www/wordpress;
        index                   index.php;
    	  listen                5050 ssl;
    	ssl_certificate         /root/mkcert/localhost.pem;
    	ssl_certificate_key     /root/mkcert/localhost-key.pem;
      	client_max_body_size    32m;
        error_page              500 502 503 504  /50x.html;
        location = /50x.html {
              root              /var/lib/nginx/html;
        }
        location ~ \.php$ {
              fastcgi_pass      127.0.0.1:9000;
              fastcgi_index     index.php;
              include           fastcgi.conf;
        }
    }
}