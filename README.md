# EasyDeploy apps for Cloud 66 Docker stacks

## Steps to build your own EasyDeploy app

1. Clone this repository
2. Create a folder with the unique name of your app
3. Create a file called app.json under the folder (see below for details of app.json)
4. Create a file called services.yml under the folder (see below for details of services.yml)
5. Make a Pull Request to merge it to the main repo.

### app.json (mandatory)

This is a json file describing the app in the folder. It contains information about the app and it's maintainer. Here is a full example of `app.json` file:

```
{
    "name" : "wordpress",
    "display_name" : "WordPress",
    "version" : "4.1.0",
    "uid" : "9bf185dc-acd6-44dc-bd1b-901bc2ea3e6e",
    "created_at" : "2015-01-19",
    "logo" : "https://s.w.org/about/images/logos/wordpress-logo-notext-rgb.png",
    "maintainer" : 
    {
        "name" : "Khash Sajadi",
        "email" : "khash@cloud66.com",
        "company" : "Cloud 66",
        "official" : false,
        "trusted" : true
    }
}
```

The following fields are mandatory:

- name
- version
- uid
- created_at
- maintainer.email

Optional fields:

- maintainer.name
- maintainer.company
- maintainer.official (is this the official EasyDeploy by the vendor)
- maintainer.trusted (is thie EasyDeploy trusted by Cloud 66)

### services.yml (mandatory)

This is the `services.yml` used by Cloud 66. For more information refer to [Cloud 66 Docker Stacks Documentation](http://help.cloud66.com/beta/docker-deployments)

### env.json (optional)

Json file containing the environment variables required by this EasyDeploy.

### readme.md (optional)

Markdown file for help and documentation of this EasyDeploy. 