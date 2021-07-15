Run `./apply.sh` to apply all files in the `resource` directory, which includes the following files:

- `app-obj.yaml` is defining the default AppProject, which is create at ArgoCD
upstream operator, not in openshift GitOps.

- `gitops-cluster-rolebinding.yaml` gives clusteradmin role to openshift GitOps
controller nesscerry access for creating policy, placementrule,
placementbinding.

- `common-app.yaml`, `groups-app.yaml` and `moc-sites-app-000.yaml` defines ArgoCD
applications, which will help up deploy the ZTP payloads to the hub cluster.

