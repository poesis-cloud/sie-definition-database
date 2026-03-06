# SIE Definition Database (Helm Chart)

This module packages the **Definition Store** for SIE as a Helm chart.

In SIE's six-plane, two-layer architecture, the Definition Store is the source of truth for **asserted definitions** (e.g., systemic primitives (Ascriptions), Norms, Mechanism rules, lifecycles, governance decisions) and their versioning/audit metadata.

## What’s in here

- `Chart.yaml`, `values.yaml`: Helm chart metadata and configuration
- `templates/`: Kubernetes manifests (StatefulSet/Service/Secrets/ConfigMaps)
- `definition/00_jsonb_bootstrap.sql`: init SQL executed on first start to bootstrap the database schema and JSONB conventions

## How to use

- For chart usage, configure values in `values.yaml` and deploy with Helm in your target cluster.
- The chart is designed to be re-runnable and environment-configurable (credentials, storage, etc.) via values.

## Notes

This repo is still in a design-oriented phase; this Helm chart is provided as deployment scaffolding for the modeled database layer.
