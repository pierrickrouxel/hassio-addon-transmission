#!/usr/bin/with-contenv bash
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare CONFIG
declare authentication_required
declare username
declare password

if ! hass.directory_exists '/data/transmission'; then
  mkdir '/data/transmission'
fi

if ! hass.file_exists '/data/transmission/settings.json'; then
  echo "{}" > /data/transmission/settings.json
fi

CONFIG=$(</data/transmission/settings.json)

# Defaults
CONFIG=$(hass.jq "${CONFIG}" ".\"incomplete-dir\"=\"/share/incomplete\"")
CONFIG=$(hass.jq "${CONFIG}" ".\"incomplete-dir-enabled\"=true")
CONFIG=$(hass.jq "${CONFIG}" ".\"download-dir\"=\"/share/downloads\"")
CONFIG=$(hass.jq "${CONFIG}" ".\"rpc-whitelist-enabled\"=false")
CONFIG=$(hass.jq "${CONFIG}" ".\"rpc-host-whitelist-enabled\"=false")
CONFIG=$(hass.jq "${CONFIG}" ".\"bind-address-ipv4\"=\"0.0.0.0\"")

authentication_required=$(hass.config.get 'authentication_required')
CONFIG=$(hass.jq "${CONFIG}" ".\"rpc-authentication-required\"=${authentication_required}")


username=$(hass.config.get 'username')
CONFIG=$(hass.jq "${CONFIG}" ".\"rpc-username\"=\"${username}\"")


password=$(hass.config.get 'password')
CONFIG=$(hass.jq "${CONFIG}" ".\"rpc-password\"=\"${password}\"")

echo "${CONFIG}" > /data/transmission/settings.json
