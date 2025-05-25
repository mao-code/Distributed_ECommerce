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