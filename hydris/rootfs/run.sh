#!/command/with-contenv bashio
# shellcheck shell=bash
# ==============================================================================
# Home Assistant App (Add-on): Hydris
# Runs Hydris
# ==============================================================================
declare -a options

if bashio::config.has_value 'world_file'; then
    options+=(--world "$(bashio::config 'world_file')")
fi

if bashio::config.true 'no_defaults'; then
    options+=(--no-defaults)
fi

if bashio::config.true 'disable_local_serial'; then
    options+=(--disable-local-serial)
fi

if bashio::config.true 'allow_netscan'; then
    options+=(--allow-netscan)
fi

if bashio::config.true 'disable_security'; then
    options+=(--disable-all-security-i-know-what-i-am-doing)
fi

if bashio::config.has_value 'allow_paths'; then
    while read -r allowed_path; do
        options+=(--allow-path "${allowed_path}")
    done < <(bashio::config 'allow_paths')
fi

if bashio::config.has_value 'plugins'; then
    while read -r plugin; do
        options+=(--plugin "${plugin}")
    done < <(bashio::config 'plugins')
fi

if bashio::config.has_value 'run_parameters'; then
    while read -r run_parameter; do
        options+=("${run_parameter}")
    done < <(bashio::config 'run_parameters')
fi

bashio::log.info "Starting Hydris..."
bashio::log.debug "hydris ${options[*]}"
exec hydris "${options[@]}"

