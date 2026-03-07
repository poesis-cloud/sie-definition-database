# SIE Definition Database deployables

This folder contains deploy/runtime assets for the Definition Database service.

- `deploy/helm/`: Helm chart for Kubernetes deployments (dev/stage/prod depending cluster/context)

## Helm

Chart path:

- `deploy/helm/sie-definition-database`

Install with defaults:

```bash
helm upgrade --install sie-definition-database \
  sie/sie-definition-database/deploy/helm/sie-definition-database \
  -n sie --create-namespace
```

Profile layering:

- Base defaults: `values.yaml`
- Platform overlays: `values-aks.yaml`, `values-onprem.yaml`
- Environment overlays: `environments/local/values.yaml`,
  `environments/preprod/values.yaml`, `environments/prod/values.yaml`

Recommended merge order (left to right):

```bash
helm upgrade --install sie-definition-database \
  sie/sie-definition-database/deploy/helm/sie-definition-database \
  -n sie --create-namespace \
  -f sie/sie-definition-database/deploy/helm/sie-definition-database/values.yaml \
  -f sie/sie-definition-database/deploy/helm/sie-definition-database/values-aks.yaml \
  -f sie/sie-definition-database/deploy/helm/sie-definition-database/environments/preprod/values.yaml \
  --set-string secrets.DB_PASSWORD="$DB_PASSWORD"
```

Secrets policy:

- Never commit production secrets in values files.
- Inject secrets at deploy time (`--set-string`) or from a cluster secret
  manager.
- The chart requires `secrets.DB_PASSWORD` explicitly.

Schema validation:

- The chart defines `values.schema.json` to validate keys/types in base,
  platform, and environment overlays.
