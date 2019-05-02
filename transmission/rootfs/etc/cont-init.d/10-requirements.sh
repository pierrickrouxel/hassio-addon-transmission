#!/usr/bin/with-contenv bashio
# ==============================================================================
# This files check if all user configuration requirements are met
# ==============================================================================

# Check authentication requirements, if enabled
if bashio::config.true 'authentication_required'; then
    if ! bashio::config.has_value 'username'; then
        bashio::die 'Transmission authentication is enabled, but no username was specified'
    fi

    if ! bashio::config.has_value 'password'; then
        bashio::die 'Transmission authentication is enabled, but no password was specified'
    fi
fi

# Check OpenVPN requirements, if enabled
if bashio::config.true 'openvpn_enabled'; then
    if ! bashio::config.has_value 'openvpn_username'; then
        bashio::die 'OpenVPN is enabled, but no username was specified'
    fi

    if ! bashio::config.has_value 'openvpn_password'; then
        bashio::die 'OpenVPN is enabled, but no password was specified'
    fi

    if ! bashio::file_exists "/config/openvpn/$(bashio::config.get 'openvpn_config').ovpn"; then
        bashio::die "The configured /config/openvpn/$(bashio::config.get 'openvpn_config').ovpn file is not found"
    fi
fi
