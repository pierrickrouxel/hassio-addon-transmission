#!/usr/bin/with-contenv bash
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare CONFIG
declare authentication_required
declare username
declare password

if ! hass.file_exists '/data/transmission/settings.json'; then
  cp '/tmp/settings.sample.json' '/data/transmission/settings.json'
fi

CONFIG=$(</data/transmission/settings.json)

authentication_required=$(hass.config.get 'authentication_required')
CONFIG=$(hass.jq "${CONFIG}" ".\"rpc-authentication-required\"=${authentication_required}")


username=$(hass.config.get 'username')
CONFIG=$(hass.jq "${CONFIG}" ".\"rpc-username\"=\"${username}\"")


password=$(hass.config.get 'password')
CONFIG=$(hass.jq "${CONFIG}" ".\"rpc-password\"=\"${password}\"")

echo "${CONFIG}" > /data/transmission/settings.json
