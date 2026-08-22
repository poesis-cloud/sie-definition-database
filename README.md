# SIE Definition Database (Helm Chart)

[![CI](https://github.com/poesis-cloud/sie-definition-database/actions/workflows/ci.yaml/badge.svg)](https://github.com/poesis-cloud/sie-definition-database/actions/workflows/ci.yaml)
[![Release](https://img.shields.io/github/v/release/poesis-cloud/sie-definition-database)](https://github.com/poesis-cloud/sie-definition-database/releases/latest)
[![Helm](https://img.shields.io/badge/Helm-chart-0F1689?logo=helm&logoColor=white)](ops/helm/Chart.yaml)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-4169E1?logo=postgresql&logoColor=white)](ops/helm/Chart.yaml)
[![License: BUSL-1.1](https://img.shields.io/badge/license-BUSL--1.1-blue)](LICENSE)

This module packages the **Definition Store** for SIE as a Helm chart.

In SIE's six-plane, two-layer architecture, the Definition Store is the source of truth for **asserted definitions** (e.g., systemic primitives (Ascriptions), Norms, Mechanism rules, lifecycles, governance decisions) and their versioning/audit metadata.

## What’s in here

- `Chart.yaml`, `values.yaml`: Helm chart metadata and configuration
- `templates/`: Kubernetes manifests (StatefulSet/Service/Secrets/ConfigMaps)
- `def/00_jsonb_bootstrap.sql`: init SQL executed on first start to bootstrap the database schema and JSONB conventions

## How to use

- For chart usage, configure values in `values.yaml` and deploy with Helm in your target cluster.
- The chart is designed to be re-runnable and environment-configurable (credentials, storage, etc.) via values.

## Notes

This repo is still in a design-oriented phase; this Helm chart is provided as deployment scaffolding for the modeled database layer.
