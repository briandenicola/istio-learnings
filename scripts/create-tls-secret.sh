#!/bin/bash 

while (( "$#" )); do
  case "$1" in
    -n)
      NAMESPACE=$2
      shift 2
      ;;
    -c)
      CERT_FILE_PATH=$2
      shift 2
      ;;
    -k)
      KEY_FILE_PATH=$2
      shift 2
      ;;
    -h|--help)
      echo "Usage: ./create-tls-secret.sh -n ${NAMESPACE} -c ${CERT_FILE_PATH} -k ${KEY_FILE_PATH}
      "
      exit 0
      ;;
    --) 
      shift
      break
      ;;
    -*|--*=) 
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
  esac
done

kubectl create ns ${NAMESPACE} || true
kubectl --namespace ${NAMESPACE} create secret tls hello-service-cert --cert=${CERT_FILE_PATH} --key=${KEY_FILE_PATH}