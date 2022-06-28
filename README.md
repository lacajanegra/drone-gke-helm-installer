# Easy Drone EKS Deployer

`drone-gke-helm-installer` is a [Drone-CI][drone] plugin that allows you to deploy a [Helm][helm] chart into a Kubernetes[k8s]EKS[eks] clusters.

[drone]: https://drone.io
[eks]: https://cloud.google.com/kubernetes-engine
[helm]: https://helm.sh
[k8s]: https://github.com/kubernetes/kubernetes

## Usage

### Statement for deploy step

Example of step on `.drone.yml` file for using this plugin:

```yaml
kind: pipeline
name: default

steps:
  - name: deploy-helm-chart-to-gke
    image: cajanegra/drone-gke-helm-installer
    settings:
      service_account: # Optional (default: service_account.json)
      gke_project_id: my-project-id
      gke_region: my-project-id # Optional (default: us-central1-a)
      cluster_name: staging # Required
      helm_chart_repo_name: rocketchat # Required
      helm_chart_repo_url: https://rocketchat.github.io/helm-charts # Required
      custom_custom_helm_chart_repo_flags: --force-update # Optional
      helm_chart_name: my-rocketchat # Required
      helm_chart: rocketchat/rocketchat # Required
      namespace: my-custom-namespace # Required
      custom_helm_chart_flags: --version 3.0.0 --set some_var=foo --create-namespace # Optional
```

### Example of Google Service Account

This is json file `service_account.json` could be used with the previous example

```json
{
  "type": "service_account",
  "project_id": "your_porject_id",
  "private_key_id": "gds7G9338eDi0As",
  "private_key": "...",
  "client_email": "user@xproject_id.iam.gserviceaccount.com",
  "client_id": "8477748929824",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/user@xproject_id.iam.gserviceaccount.com"
}
```
