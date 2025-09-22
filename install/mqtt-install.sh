#!/usr/bin/env bash

# Copyright (c) 2021-2025 tteck
# Author: tteck (tteckster)
# License: MIT | https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE
# Source: https://mosquitto.org/

source /dev/stdin <<<"$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Mosquitto MQTT Broker"
source /etc/os-release
$STD apt-get update
$STD apt-get -y install mosquitto
$STD apt-get -y install mosquitto-clients

cat <<EOF >/etc/mosquitto/conf.d/default.conf
allow_anonymous false
persistence true
password_file /etc/mosquitto/passwd
listener 1883
EOF
msg_ok "Installed Mosquitto MQTT Broker"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
