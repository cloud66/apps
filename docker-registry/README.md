# Cloud 66 EasyDeploy&trade;

## Docker Registry

### Installation 
1. Install this EasyDeploy&trade; App from the [Cloud 66 App Store](https://app.cloud66.com/easydeploys)
2. **Optional**: Modify the default `REPOSITORY_USER` and/or `REPOSITORY_PASSWORD` ENV vars (in the advanced tab)
3. **Optional**: Configure your registry further see — *Registry Configuration* below. This can be done any time after initial deployment
4. Deploy your stack to your selected cloud/servers!
6. **Optional**: Add a [failover group](http://help.cloud66.com/network/failover-groups) to add DNS resiliance against server IP changes
7. Create an external DNS entry for your stack (point it to your server A-Record or failover group CNAME above)
8. Add an SSL certificate to your stack via the (SSL Stack Addin)[http://help.cloud66.com/stack-add-ins/ssl-certificate] (this is necessary as your repo is secured with basic authentication)
9. All done, you're running your own private registry!

### Optional: Registry Configuration 
1. Change registry users/passwords
```
docker login username=$REGISTRY_USER --password=$REGISTRY_PASSWORD --email=[YOUR-EMAIL] https://[YOUR-DNS] 
```


### Usage
1. Log in to your private registry
```
docker login username=$REGISTRY_USER --password=$REGISTRY_PASSWORD --email=[YOUR-EMAIL] https://[YOUR-DNS] 
```
2. **Optional**: Add your private registry to your [account's image repositories](https://app.cloud66.com/image_repositories). This will allow deployment of images stored in your private registry.
3. Profit! 





