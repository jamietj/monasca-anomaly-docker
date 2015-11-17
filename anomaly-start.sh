#!/bin/bash
/setup/demo-start.sh
/etc/init.d/monasca-anomaly-engine start
/opt/monasca/bin/monasca-notification
tail -f /var/log/monasca/api/monasca-api.log

