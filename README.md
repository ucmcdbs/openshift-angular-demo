# OpenShift Angular Demo

Demonstrate build and deployment of an Angular application in OpenShift

## Local Development

### Development server

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

### Code scaffolding

Run `ng generate component component-name` to generate a new component. You can also use `ng generate directive|pipe|service|class|guard|interface|enum|module`.

### Build

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory.

### Running unit tests

Run `ng test` to execute the unit tests via [Karma](https://karma-runner.github.io).

### Running end-to-end tests

Run `ng e2e` to execute the end-to-end tests via a platform of your choice. To use this command, you need to first add a package that implements end-to-end testing capabilities.

## Package and Deploy

### Build Image

Build and package the application into a container. Refer Dockerfile for the steps to build.

- Use Node.js as the builder image
- Install dependencies
- Build the web application for production
- Use Caddy, a lightweight web server, as the deployment image
- Copy dist/{app} folder from builder image into deployment image
- Set the command to run Caddy with the app folder as the root
- Expose Caddy's port

```bash
podman build -t openshift-angular-demo:latest .
```

Note that the build requires node modules to be downloaded every time. Use a local
NPM repository for better performance and reduced access over internet.

### Run Locally

```bash
podman run -p 4200:4200 openshift-angular-demo:latest
```

### Deploy in OpenShift

Create Kubernetes objects using OpenShift Template

- ImageStream
- BuildConfig
- Deployment
- Service
- Route

```bash
oc policy add-role-to-group system:image-builder system:serviceaccounts:openshift-angular-demo -n demo-images
oc process -f template.yaml | oc apply -n openshift-demo -f-
```

### Build and Deploy in OpenShift

```
oc start-build openshift-angular-demo --follow -n openshift-demo
oc rollout restart deployment/openshift-angular-demo -n openshift-demo
```

Visit https://openshift-angular-demo-openshift-demo.apps.{openshift-domain}
