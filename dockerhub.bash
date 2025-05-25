# === 建 docker image 並推到 Docker Hub ===
REG=codingmao
docker build -t $REG/ds_ecommerce_shopping:1.0 ./shopping-service
docker build -t $REG/ds_ecommerce_payment:1.0  ./payment-service
docker build -t $REG/ds_ecommerce_notification:1.0 ./notification-service
# docker build -t $REG/ds_ecommerce_front:1.0 ./frontend
docker push $REG/ds_ecommerce_shopping:1.0 && docker push $REG/ds_ecommerce_payment:1.0 \
  && docker push $REG/ds_ecommerce_notification:1.0 && # docker push $REG/ds_ecommerce_front:1.0



