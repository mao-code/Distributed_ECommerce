# === 部署到 K3s ===
kubectl apply -f k8s/shopping.yaml
kubectl apply -f k8s/payment.yaml
kubectl apply -f k8s/notification.yaml
kubectl apply -f k8s/hpa-shopping.yaml

# kubectl apply -f k8s/frontend.yaml

# ---------------------------
# Stop Kafka (in the kafka namespace, a virtual cluster)
# kubectl scale statefulset kafka-controller --replicas=0 -n kafka

# Restart Kafka
# kubectl scale statefulset kafka-controller --replicas=3 -n kafka
# ---------------------------
# Below is the commands to monitor all related resources:
# 1. To see all pods, services, and deployments:
# watch -n1 'kubectl get nodes,pods,svc'

# 2. To see resources usage and HPA: 
# watch -n1 'kubectl get hpa; echo "---"; kubectl top pods'

# 3. Execute k6 script (see the pane in step2)
# k6 run k6/load.js

# 4. See kafka logs:
# kubectl logs -f kafka-controller-0 -n kafka