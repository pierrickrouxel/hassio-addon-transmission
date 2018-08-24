#!/usr/bin/with-contenv bash
# ==============================================================================
#
# Transmission
#
# The bittorent client for Hass.io.
#
# ==============================================================================
set -o errexit  # Exit script when a command exits with non-zero status
set -o errtrace # Exit on error inside any functions or sub-shells
set -o nounset  # Exit script on use of an undefined variable
set -o pipefail # Return exit status of the last command in the pipe that failed

# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

# ==============================================================================
# RUN LOGIC
# ------------------------------------------------------------------------------
main() {
    if hass.config.true 'openvpn_enabled'; then
        exec /usr/sbin/openvpn --config /etc/openvpn/config.ovpn --script-security 2 --up /etc/openvpn/up.sh --down /etc/openvpn/down.sh
    else
        exec /usr/bin/transmission-daemon --foreground --config-dir /data/transmission
    fi
}
main "$@"
