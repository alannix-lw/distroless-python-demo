# Distroless Python Container

The purpose of this repository is to demonstrate Lacework's container vulnerability scanning capabilities within GitHub Actions CI.

The base container is pulled from `gcr.io/distroless/python3:latest` and attemtping to deploy a vulnerable Python module should prevent the contaianer build process from completing.
