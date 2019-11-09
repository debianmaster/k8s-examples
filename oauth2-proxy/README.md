> https://github.com/pusher/oauth2_proxy/releases

```sh
docker run -d -p 8099:8080 openshift/hello-openshift:latest
```

```sh
oauth2 \
--email-domain="*" \
--client-secret=dummy \
--client-id=dummy \
--cookie-secret=super-secret-cookie -provider=github \
-upstream http://localhost:8099 \
-redirect-url=http://127.0.0.1:4180/oauth2/callback \
-cookie-secure=false
```



```sh
helm install --name authproxy \
    --namespace=ingress \
    --set config.clientID=<github oauth app client id> \
    --set config.clientSecret=<github oauth app client secret> \
    --set config.cookieSecret=<some secret>  \
    --set extraArgs.provider=github \
    --set authenticatedEmailsFile.enabled=true \
    --set authenticatedEmailsFile.restricted_access="abc@gmail.com" \
    stable/oauth2-proxy
 ```
