SHELL := /bin/bash

.PHONY: local-check local-up local-down

NAMESPACE ?= sie
RELEASE_DEF_DB ?= sie-definition-database

DEF_DB_CHART ?= deploy/helm/sie-definition-database

PORT_FORWARD_PID_FILE ?= .local-port-forwards.pids

local-check:
	@command -v kubectl >/dev/null 2>&1 || { echo "Missing required command: kubectl"; exit 1; }
	@command -v helm >/dev/null 2>&1 || { echo "Missing required command: helm"; exit 1; }
	@kubectl config current-context >/dev/null 2>&1 || { echo "No active Kubernetes context. Configure kubeconfig first."; exit 1; }
	@kubectl get ns >/dev/null 2>&1 || { echo "Cannot reach Kubernetes API with current context."; exit 1; }
	@test -d "$(DEF_DB_CHART)" || { echo "Missing chart directory: $(DEF_DB_CHART)"; exit 1; }
	@echo "local-check passed"

local-up:
	@$(MAKE) local-check
	kubectl get ns $(NAMESPACE) >/dev/null 2>&1 || kubectl create ns $(NAMESPACE) >/dev/null
	helm upgrade --install $(RELEASE_DEF_DB) $(DEF_DB_CHART) -n $(NAMESPACE) --create-namespace --wait --timeout 10m0s --set persistence.enabled=false
	@if [[ -f "$(PORT_FORWARD_PID_FILE)" ]]; then \
		xargs -r kill < "$(PORT_FORWARD_PID_FILE)" 2>/dev/null || true; \
		rm -f "$(PORT_FORWARD_PID_FILE)"; \
	fi
	nohup kubectl -n $(NAMESPACE) port-forward svc/$(RELEASE_DEF_DB) 5432:5432 >/tmp/sie-db-pf-postgres.log 2>&1 & echo $$! >> "$(PORT_FORWARD_PID_FILE)"
	@echo "Definition Database is ready and port-forward started."

local-down:
	@if [[ -f "$(PORT_FORWARD_PID_FILE)" ]]; then \
		xargs -r kill < "$(PORT_FORWARD_PID_FILE)" 2>/dev/null || true; \
		rm -f "$(PORT_FORWARD_PID_FILE)"; \
	fi
	helm uninstall $(RELEASE_DEF_DB) -n $(NAMESPACE) || true