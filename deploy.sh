#bash
kubectl apply -f <(istioctl kube-inject -f ./istio-weightedrules.yaml)