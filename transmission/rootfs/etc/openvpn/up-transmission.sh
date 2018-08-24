#!/usr/bin/with-contenv bash
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare CONFIG

CONFIG=$(</data/transmission/settings.json)

CONFIG=$(hass.jq "${CONFIG}" ".\"bind-address-ipv4\"=\"${1}\"")

echo "${CONFIG}" > /data/transmission/settings.json

exec /usr/bin/transmission-daemon --foreground --config-dir /data/transmission
