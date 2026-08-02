# sample-api

Reference vendor service for the swiftwad EKS platform POC. Small Go HTTP server that meets the [vendor conformance requirements](https://github.com/juwondre/swiftwad-gitops/blob/main/docs/vendor-conformance.md).

On merge to `main`, CI builds the image, pushes it to ECR, and bumps the dev image tag in the gitops repo. ArgoCD takes it from there. Nobody in this repo touches infrastructure.

## Environment variables

| Name | Required | Purpose | Example |
|---|---|---|---|
| `PORT` | no | Listen port, defaults to 8080 | `8080` |
| `APP_ENV` | no | Environment label returned by `/` | `dev` |
| `APP_VERSION` | no | Version string returned by `/` | git SHA |

## Endpoints

- `/healthz` — liveness, always 200 while the process is up
- `/readyz` — readiness, 503 during startup and after SIGTERM while draining
- `/` — service info JSON

## Run locally

```sh
go run . 
curl localhost:8080/readyz
```
