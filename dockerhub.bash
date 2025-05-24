# === 建 docker image 並推到 Docker Hub ===
# REG=codingmao
# docker build -t $REG/ds_ecommerce_shopping:1.0 ./shopping-service
# docker build -t $REG/ds_ecommerce_payment:1.0  ./payment-service
# docker build -t $REG/ds_ecommerce_notification:1.0 ./notification-service
# # docker build -t $REG/ds_ecommerce_front:1.0 ./frontend
# docker push $REG/ds_ecommerce_shopping:1.0 && docker push $REG/ds_ecommerce_payment:1.0 \
#   && docker push $REG/ds_ecommerce_notification:1.0 && # docker push $REG/ds_ecommerce_front:1.0

# === 部署到 K3s ===
kubectl apply -f k8s/shopping.yaml
kubectl apply -f k8s/payment.yaml
kubectl apply -f k8s/notification.yaml
kubectl apply -f k8s/hpa-shopping.yaml

# kubectl apply -f k8s/frontend.yaml

# Stop Kafka and Zookeeper (in the kafka namespace, a virtual cluster)
# kubectl scale statefulset kafka-controller --replicas=0 -n kafka
# kubectl scale statefulset zookeeper --replicas=0 -n kafka

# Restart Kafka and Zookeeper
# kubectl scale statefulset kafka-controller --replicas=3 -n kafka
# kubectl scale statefulset zookeeper --replicas=3 -n kafka