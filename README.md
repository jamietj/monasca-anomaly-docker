# monasca-anomaly-docker
Extension of monasca/demo docker to include monasca-anomaly

Run with:

docker run -d -p 192.168.1.200:5000:5000 -p 192.168.1.200:35357:35357 -p 192.168.1.200:8080:8080 -p 0.0.0.0:80:80 biirdy/monasca-anomaly-docker

Exposes ports for keystone, monasca-api and apache.

To check the notifier and monasca are running:
ps awx | grep monasca

Run monasca agent with:
service monasca-agent start|stop|status|info

Run the notifier with:
/opt/monasca/bin/monasca-notification

To direct a notification to OTE (in the web UI):
Page Monitoring->Notifications +Create Notification
Name: OTE
Type: Webhook
Address: http://localhost/box_connector

Then goto Alarm Definitions and Edit the one you want so it uses the OTE notification


