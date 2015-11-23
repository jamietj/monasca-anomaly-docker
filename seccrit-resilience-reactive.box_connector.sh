#!/bin/bash

# SECCRIT connector for reactive.box

RB_URL="http://etra-id.com:3344"
RB_USER="seccrit"
RB_PASSWORD="seccrit"
RB_PATH="/home/OTE/"
RB_AUTHINFO="reactive.box_authInfo"
RB_RESULT="result.json"
LAYER="seccrit.alerts"

function login_rb {
        login_response=$(curl -s -d "user=$RB_USER&password=$RB_PASSWORD" -H "Content-Type: application/x-www-form-urlencoded" $RB_URL/api/login)
        login_status=$(echo $login_response | jq -r '.status')
        if [ "$login_status" = "success" ]; then
                login_authtoken=$(echo $login_response | jq -r '.data.authToken')
                login_userId=$(echo $login_response | jq -r '.data.userId')
                echo $login_authtoken > $RB_PATH$RB_AUTHINFO
                echo $login_userId >> $RB_PATH$RB_AUTHINFO
        fi
}

function send_json {
        curl_response=$(curl -d "$json" -H "Content-type: application/json" -H "X-Auth-Token: $login_authtoken" -H "X-User-Id: $login_userId" $RB_URL/api/$LAYER 2>/dev/null)
        curl_status=$(echo $curl_response | jq -r '.status')
	echo $curl_response > $RB_PATH$RB_RESULT
}

timestamp=$(($(date +%s%N)/1000000))
json=$(echo $@ | jq -c -M '.timestamp="{timestamp}"' | sed -e "s/\"{timestamp}\"/{\"\$date\":$timestamp}/g")

json=$(echo $json | jq -c -M '.facility="OTE"')
json=$(echo $json | jq -c -M '.tool="resiliencefw"')
json=$(echo $json | jq -c -M '.severity=5')

echo $json > "/home/OTE/raw.json"

login_authtoken=$(cat $RB_PATH$RB_AUTHINFO 2>/dev/null | head -1 2>/dev/null)
login_userId=$(cat $RB_PATH$RB_AUTHINFO 2>/dev/null | tail -1 2>/dev/null)

if [ -z $login_authtoken ] || [ -z $login_authtoken ]; then
        login_rb
fi

send_json

if [ "$curl_status" != "success" ]; then
        login_rb
        send_json
fi

