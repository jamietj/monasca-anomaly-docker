# monasca-anomaly-docker
Extension of monasca/demo docker to include monasca-anomaly

Run with:

docker run -d -p 192.168.1.200:5000:5000 -p 192.168.1.200:35357:35357 -p 192.168.1.200:8080:8080 -p 0.0.0.0:80:80 biirdy/monasca-anomaly-docker

Exposes ports for keystone, monasca-api and apache.
