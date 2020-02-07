#!/bin/bash
helm init --client-only
export repo=$(cat /tmp/values/repo)
export chart=$(cat /tmp/values/chart)
export version=$(cat /tmp/values/version)
export install=$(cat /tmp/values/install)
helm fetch --repo ${repo} --untar  --untardir ./tmp/   --version ${version}  ${chart}

if [ "$install" = "true" ]; then
    helm template ./tmp/${chart} -f /tmp/values/values.yaml | kubectl -s https://kubernetes --token="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt  apply -f-
else
    helm template ./tmp/${chart} -f /tmp/values/values.yaml | kubectl -s https://kubernetes --token="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt  delete -f-
fi
