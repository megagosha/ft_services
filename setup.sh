#bin/zsh
minikube delete
minikube config set memory 6144
minikube config set cpus 4
minikube start --vm-driver=virtualbox
eval $(minikube docker-env)
echo "Enabling addons..."
minikube addons enable metallb
minikube addons enable dashboard
minikube addons enable metrics-server
echo "Launching dashboard..."
minikube dashboard &

docker build -t mysql-custom srcs/mysql
docker build -t phpmyadmin-custom srcs/phpmyadmin
docker build -t nginx-custom srcs/nginx
docker build -t vsftpd-custom srcs/ftps
docker build -t graphana-custom srcs/graphana
docker build -t influxdb-custom srcs/influxdb
docker build -t wordpress-custom srcs/wordpress

#kubectl create -f ./srcs/
kubectl apply -f srcs/secrets.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/master/manifests/metallb.yaml
kubectl apply -f srcs/metal-deployment.yaml
kubectl apply -f srcs/wordpress-deployment.yaml
kubectl apply -f srcs/ftps-deployment.yaml
kubectl apply -f srcs/mysql-deployment.yaml
kubectl apply -f srcs/phpmyadmin-deployment.yaml
kubectl apply -f srcs/nginx-deployment.yaml
kubectl apply -f srcs/influxdb-deployment.yaml
kubectl apply -f srcs/graphana-deployment.yaml
