#!/usr/bin/with-contenv bashio
# ==============================================================================

declare CONFIG
declare authentication_required
declare username
declare password
declare downloads_dir
declare incomplete_dir

if ! bashio::fs.directory_exists '/data/transmission'; then
  mkdir '/data/transmission'
fi

if ! bashio::fs.file_exists '/data/transmission/settings.json'; then
  echo "{}" > /data/transmission/settings.json
fi

CONFIG=$(</data/transmission/settings.json)

# Defaults
incomplete_dir=$(bashio::config 'incomplete_dir')
downloads_dir=$(bashio::config 'downloads_dir')
CONFIG=$(bashio::jq "${CONFIG}" ".\"incomplete-dir\"=\"${incomplete_dir}\"")
CONFIG=$(bashio::jq "${CONFIG}" ".\"incomplete-dir-enabled\"=true")
CONFIG=$(bashio::jq "${CONFIG}" ".\"download-dir\"=\"${downloads_dir}\"")
CONFIG=$(bashio::jq "${CONFIG}" ".\"rpc-whitelist-enabled\"=false")
CONFIG=$(bashio::jq "${CONFIG}" ".\"rpc-host-whitelist-enabled\"=false")
CONFIG=$(bashio::jq "${CONFIG}" ".\"bind-address-ipv4\"=\"0.0.0.0\"")

authentication_required=$(bashio::config 'authentication_required')
CONFIG=$(bashio::jq "${CONFIG}" ".\"rpc-authentication-required\"=${authentication_required}")


username=$(bashio::config 'username')
CONFIG=$(bashio::jq "${CONFIG}" ".\"rpc-username\"=\"${username}\"")


password=$(bashio::config 'password')
CONFIG=$(bashio::jq "${CONFIG}" ".\"rpc-password\"=\"${password}\"")

echo "${CONFIG}" > /data/transmission/settings.json
