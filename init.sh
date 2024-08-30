#!/bin/bash

{
  echo receiver="beast-tcp"
  echo fr24key="${FR24KEY}"
  echo host="${BEASTHOST}:${BEASTPORT}"
  echo bs="no"
  echo raw="no"
  echo logmode="0"
  echo logpath="/var/log"
  if [ "${MLAT}" = 'yes' ]; then
    echo mlat="yes"
    echo mlat-without-gps="yes"
  else
    echo mlat="no"
    echo mlat-without-gps="no"
  fi
  if [ -n "${BIND_INTERFACE}" ]; then
    echo bind-interface="${BIND_INTERFACE}"
  fi
  if [ -n "${NTP_SERVER}" ]; then
    echo ntp-server="${NTP_SERVER}"
  fi
} > /etc/fr24feed.ini

/usr/local/bin/fr24feed
