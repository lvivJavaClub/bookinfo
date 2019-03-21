# Istio playbook

This example deploys a sample application composed of four separate microservices used to demonstrate various Istio features. The application displays information about a book, similar to a single catalog entry of an online book store. Displayed on the page is a description of the book, book details (ISBN, number of pages, and so on), and a few book reviews. See [Bookinfo Application](https://istio.io/docs/examples/bookinfo/)

# Tasks

How to do single specific targeted activities with the Istio system. See [Tasks](https://istio.io/docs/tasks/)

[Traffic Management](https://istio.io/docs/tasks/traffic-management/)
Tasks that demonstrate Istio's traffic routing features.

Security
Demonstrates how to secure the mesh.

Policies
Demonstrates policy enforcement features.

Telemetry
Demonstrates how to collect telemetry information from the mesh.

# Requirements

Use `make` for install/setup/stop...

# Help

## General

* `make install` - install istio
* `make start`   - install bookinfo
* `make status`  - show status
* `make stop`    - stop bookinfo

## Fault Injection:

See [Fault Injection](https://istio.io/docs/tasks/traffic-management/fault-injection/)
This task shows you how to inject faults to test the resiliency of your application.

* `make tratings-test-delay` - Injecting an HTTP delay fault
* `make ratings-test-abort`  - Injecting an HTTP abort fault
