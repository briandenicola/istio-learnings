#!/bin/bash 

while (( "$#" )); do
  case "$1" in
    -s)
      SECRET_NAME=$2
      shift 2
      ;;
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
      echo "Usage: ./create-tls-secret.sh -n ${NAMESPACE} -c ${CERT_FILE_PATH} -k ${KEY_FILE_PATH} [-s ${SECRET_NAME}]
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

if [[ -z "${SECRET_NAME}" ]]; then
  SECRET_NAME=hello-service-cert
fi 

kubectl create ns ${NAMESPACE} || true
kubectl --namespace ${NAMESPACE} create secret tls ${SECRET_NAME} --cert=${CERT_FILE_PATH} --key=${KEY_FILE_PATH}