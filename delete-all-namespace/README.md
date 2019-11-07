
```sh
kubectl delete "$(kubectl api-resources --namespaced=true --verbs=delete -o name | tr "\n" "," | sed -e 's/,$//')" --all "$@"
```

Credits:  https://gist.github.com/superbrothers/b428cd021e002f355ffd6dd421b75f70
