#!/bin/bash
/setup/demo-start.sh
service monasca-anomaly-engine start
tail -f /var/log/monasca/api/monasca-api.log
