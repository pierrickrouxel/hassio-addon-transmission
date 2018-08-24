#!/usr/bin/with-contenv bash
# ==============================================================================
# This files check if all user configuration requirements are met
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

# Check authentication requirements, if enabled
if hass.config.true 'authentication_required'; then
    if ! hass.config.has_value 'username'; then
        hass.die 'Transmission authentication is enabled, but no username was specified'
    fi

    if ! hass.config.has_value 'password'; then
        hass.die 'Transmission authentication is enabled, but no password was specified'
    fi
fi

# Check OpenVPN requirements, if enabled
if hass.config.true 'openvpn_enabled'; then
    if ! hass.config.has_value 'openvpn_username'; then
        hass.die 'OpenVPN is enabled, but no username was specified'
    fi

    if ! hass.config.has_value 'openvpn_password'; then
        hass.die 'OpenVPN is enabled, but no password was specified'
    fi

    if ! hass.file_exists "/config/openvpn/$(hass.config.get 'openvpn_config').ovpn"; then
        hass.die "The configured /config/openvpn/$(hass.config.get 'openvpn_config').ovpn file is not found"
    fi
fi
