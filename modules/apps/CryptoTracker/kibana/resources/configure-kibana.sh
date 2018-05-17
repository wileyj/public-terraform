#!/bin/bash
curl -XPUT -D- "${ELASTICSEARCH_URL}/.kibana/index-pattern/eth.*.ticker" \
    -H 'Content-Type: application/json' \
    -d '{"title" : "eth.*.ticker", "timeFieldName": "tracker_time", "notExpandable": true}'


curl -XPUT -D- "${ELASTICSEARCH_URL}/.kibana/index-pattern/btc.*.ticker" \
        -H 'Content-Type: application/json' \
        -d '{"title" : "btc.*.ticker", "timeFieldName": "tracker_time", "notExpandable": true}'

curl -XPUT -D- "${ELASTICSEARCH_URL}/.kibana/index-pattern/*.*.ticker" \
        -H 'Content-Type: application/json' \
        -d '{"title" : "*.*.ticker", "timeFieldName": "tracker_time", "notExpandable": true}'

curl -XPUT -D- "${ELASTICSEARCH_URL}/.kibana/config/5.5.0" \
            -H 'Content-Type: application/json' \
            -d '{"defaultIndex": "eth.*.ticker"}'

python /tmp/load_dashboards.py /tmp/objects_visualizations.json "${ELASTICSEARCH_URL}"
