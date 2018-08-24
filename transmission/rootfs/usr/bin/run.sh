#!/usr/bin/with-contenv bash
# ==============================================================================
#
# Community Hass.io Add-ons: Transmission
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

openvpn_start() {
    declare openvpn_config
    declare openvpn_username
    declare openvpn_password

    mkdir -p /etc/openvpn

    openvpn_config=$(hass.config.get 'openvpn_config')
    cp "/config/openvpn/${openvpn_config}.ovpn" /etc/openvpn/

    openvpn_username=$(hass.config.get 'openvpn_username')
    echo "${openvpn_username}" > /etc/openvpn/credentials
    openvpn_password=$(hass.config.get 'openvpn_password')
    echo "${openvpn_password}" >> /etc/openvpn/credentials
    chmod 600 /etc/openvpn/credentials

    sed -i 's/auth-user-pass.*/auth-user-pass \/etc\/openvpn\/credentials/g' "/etc/openvpn/${openvpn_config}.ovpn"

    sed -i "1a\/etc/openvpn/up-transmission.sh \"\${4}\" &\n" /etc/openvpn/up.sh

    exec /usr/sbin/openvpn --config "/etc/openvpn/${openvpn_config}.ovpn" --script-security 2 --up /etc/openvpn/up.sh --down /etc/openvpn/down.sh
}

# ==============================================================================
# RUN LOGIC
# ------------------------------------------------------------------------------
main() {
    if hass.config.true 'openvpn_enabled'; then
        openvpn_start
    else
        exec /usr/bin/transmission-daemon --foreground --config-dir /data/transmission
    fi
}
main "$@"
