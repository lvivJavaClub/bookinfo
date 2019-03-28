help:
	clear
	@echo "Help"
	@echo "make install - install istio"
	@echo "make start   - install bookinfo"
	@echo "make status  - show status"
	@echo "make stop    - stop bookinfo"
	@echo ""
	@echo "Fault Injection:"
	@echo "make tratings-test-delay - Injecting an HTTP delay fault"
	@echo "make ratings-test-abort  - Injecting an HTTP abort fault"
	@echo ""
	@echo "Traffic Shifting:"
	@echo "make reviews-50-v3 - Apply weight-based routing"
	@echo ""
	@echo "Mirroring:"
	@echo "make mirroring - Apply mirroring routing"
start:
	clear
	@echo "Start..."
	wget https://raw.githubusercontent.com/istio/istio/release-1.1/samples/bookinfo/platform/kube/bookinfo.yaml
	istioctl kube-inject -f bookinfo.yaml > bookinfo-istio.yaml
	kubectl apply -f bookinfo-istio.yaml
	wget https://raw.githubusercontent.com/istio/istio/release-1.1/samples/bookinfo/networking/bookinfo-gateway.yaml
	kubectl apply -f bookinfo-gateway.yaml
	wget https://raw.githubusercontent.com/istio/istio/release-1.1/samples/bookinfo/networking/destination-rule-all-mtls.yaml
	kubectl apply -f destination-rule-all-mtls.yaml
virtual-service-all-v1:
	clear
	@echo "Virtual service all v1..."
	wget https://raw.githubusercontent.com/istio/istio/release-1.1/samples/bookinfo/networking/virtual-service-all-v1.yaml
	kubectl apply -f virtual-service-all-v1.yaml
	weg https://raw.githubusercontent.com/istio/istio/release-1.1/samples/bookinfo/networking/virtual-service-reviews-test-v2.yaml
	kubectl apply -f virtual-service-reviews-test-v2.yaml
tratings-test-delay:
	clear
	@echo "Tratings test delay:"
	weg https://raw.githubusercontent.com/istio/istio/release-1.1/samples/bookinfo/networking/virtual-service-ratings-test-delay.yaml
	kubectl apply -f virtual-service-ratings-test-delay.yaml
ratings-test-abort:
	clear
	@echo "Ratings test abort:"
	weg https://raw.githubusercontent.com/istio/istio/release-1.1/samples/bookinfo/networking/virtual-service-ratings-test-abort.yaml
	kubectl apply -f virtual-service-ratings-test-abort.yaml
reviews-50-v3:
	clear
	@echo "Apply weight-based routing:"
	wget https://raw.githubusercontent.com/istio/istio/release-1.1/samples/bookinfo/networking/virtual-service-reviews-50-v3.yaml
	kubectl apply -f virtual-service-reviews-50-v3.yaml
mirroring:
	clear
	@echo "Apply mirroring routing:"
	kubectl apply -f virtual-service-reviews-mirroring.yaml
install:
	clear
	@echo "Installing..."
	curl -L https://git.io/getLatestIstio | ISTIO_VERSION=1.1.0 sh -
	cd istio-1.1.0/
	for i in install/kubernetes/helm/istio-init/files/crd*yaml; do kubectl apply -f $i; done
	kubectl apply -f install/kubernetes/istio-demo.yaml
status:
	clear
	@echo "Status:"
	kubectl get services,pods
	kubectl exec -it $(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}') -c ratings -- curl productpage:9080/productpage | grep -o "<title>.*</title>"
	kubectl get svc istio-ingressgateway -n istio-system
stop:
	clear
	@echo "Stop..."
	kubectl delete -f bookinfo-istio.yaml
	kubectl delete -f bookinfo-gateway.yaml
	kubectl delete -f destination-rule-all-mtls.yaml
	kubectl delete virtualservices --all
