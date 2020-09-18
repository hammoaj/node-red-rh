# Node-RED on Docker/Openshift with optional Cloudant/CouchDB filestore (Red Hat ubi8 base)

This repository is an example Node-RED application that can be deployed into
a Red Hat Openshift environment (or other Docker environments) with only a couple clicks.

## Using Cloudant or CouchDB database as your file store

By default, this uses a local filestore at `/data` which should be mounted as persistent
storage. Alternatively you can use Cloudant or CouchDB as your filestore by setting the full URL of a Cloudant/CouchDB instance in a 
Secrets file (Openshift) or environment variables (Docker).

- Create a new Cloudant/CouchDB instance and create a set of credentials
- If you are using Cloudant, there will be an entry for *url*, make a note of the full URL. For CouchDB use the URL of your instance with the user name and password you have set up.
- In Openshift, add a new secret:
   * Secret name: `NODE_RED_STORAGE_URL`
   * Secret value: URL from the Cloudant credentials file or CouchDB URL
- In Docker, set this as an environment variable on the Docker run command: `-e NODE_RED_STORAGE_URL=<url>`
- Redeploy the application

It includes a set of default flows that are automatically deployed the first time
Node-RED runs.

## Customising Node-RED

This repository is here to be cloned, modified and re-used to allow anyone create
their own Node-RED based application that can be quickly deployed to IBM Cloud or other Openshift
environments.

The default flows are stored in the `defaults` directory in the file called `flow.json`.
When the application is first started, this flow is copied to the attached Cloudant
instance. When a change is deployed from the editor, the version in cloudant will
be updated - not this file.

The web content you get when you go to the application's URL is stored under the
`public` directory.

Additional nodes can be added to the `package.json` file and all other Node-RED
configuration settings can be set in `docker-settings.js`.


## Environment Variables

The following environment variables can be set in the Secrets file to configure the application:

 - `NODE_RED_STORAGE_URL` - the full Cloudant URL for the Cloudant service to be used
 - `NODE_RED_STORAGE_DB_NAME` - the name of the database to use on Cloudant
 - `NODE_RED_STORAGE_APP_NAME` - the prefix used in document names, allowing multiple instances
    to share the same database.
 - `NODE_RED_USERNAME`, `NODE_RED_PASSWORD` - if set, used to secure the editor
