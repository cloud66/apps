## Docker Registry EasyDeploy&trade;

The Docker Registry is a stateless, highly scalable server side application that stores and lets you distribute Docker images. Cloud 66 has wrapped this into an EasyDeploy&trade; App that be automatically installed, secured and configured in your own server environments for storage of private images. Read [more about the registry](https://docs.docker.com/registry/)

### Installation 
1. Install this EasyDeploy&trade; App from the [Cloud 66 App Store](https://app.cloud66.com/easydeploys)
2. **Optional:** Modify the default `REPOSITORY_USER` and/or `REPOSITORY_PASSWORD` ENV vars (in the advanced tab)
3. **Optional:** Configure your registry further see — *Advanced Configuration* below. This can be done any time after initial deployment
4. Deploy your stack to your selected cloud/servers!
6. **Optional:** Add a [failover group](http://help.cloud66.com/network/failover-groups) to add DNS resiliance against server IP changes
7. Create an external DNS entry for your stack (point it to your server A-Record or failover group CNAME above)
8. Add an SSL certificate to your stack via the (SSL Stack Addin)[http://help.cloud66.com/stack-add-ins/ssl-certificate] (this is necessary as your repo is secured with basic authentication)
9. All done, you're running your own private registry!

### Usage
1. Log in to your private registry
```
docker login username=$REGISTRY_USER --password=$REGISTRY_PASSWORD --email=[YOUR-EMAIL] https://[YOUR-DNS] 
```
2. **Optional:** Add your private registry to your [account's image repositories](https://app.cloud66.com/image_repositories). This will allow deployment of images stored in your private registry. You will need to use the username and passwords that you have configurated (default is the value of $REGISTRY_USER and $REGISTRY_PASSWORD)
3. Profit! 

### Optional: Advanced Configuration 

#### Change the Registry Configuration

The private registry uses the Docker Registry (version 2.x.x) as its framework and the Docker Registry allows for all configuration items to be provided by ENV vars. So we can configure your private registry via these ENV vars. See the below sample to be added to your service configuration OR stack environment variables (then stack redeployed)

__Sample Registry Configuration:__ AWS S3 Storage Backend
```
  REGISTRY_STORAGE: s3
  REGISTRY_STORAGE_S3_REGION: us-east-1
  REGISTRY_STORAGE_S3_BUCKET: ****** 
  REGISTRY_STORAGE_S3_ACCESSKEY: ****** 
  REGISTRY_STORAGE_S3_SECRETKEY: ******
  REGISTRY_STORAGE_S3_ENCRYPT: true
  REGISTRY_STORAGE_S3_SECURE: true
  REGISTRY_STORAGE_S3_V4AUTH: false
  REGISTRY_STORAGE_S3_CHUNKSIZE: 5242880
  REGISTRY_STORAGE_S3_ROOTDIRECTORY: /my_images
```

#### Modify docker users/passwords after deployment

Your private registry is fronted by an NGINX instance that is using basic authentication to authorize your user.
You can modfy the users by editing the file `/etc/nginx/conf.d/cloud66.htpasswd` directly. 
however, to generate and store encrypted (sensible) password values you can use something like the below script:
```
# delete all content
> /etc/nginx/conf.d/cloud66.htpasswd

# repeat below as needed
user=bob password=jesk
printf "$user:$(openssl passwd -apr1 $password)\n" >> /etc/nginx/conf.d/cloud66.htpasswd
user=tim password=cobb 
printf "$user:$(openssl passwd -apr1 $password)\n" >> /etc/nginx/conf.d/cloud66.htpasswd
...

# pick up changes in nginx
sudo service nginx reload
```
Note that this should be run on all docker servers that are serving your private registry, and can be implemented as a deploy hook if needed (see the `custom_config/deploy_hooks.yml` that is present and used in this repo)
