# Home Assistant App (Add-on): Hydris

Hydris is an open-source coordination engine for sensors, assets, and mission
systems across large-area networks.

This app/add-on packages the Hydris Linux CLI release for Home Assistant
Supervisor.

## Initial Setup

1. Install the app/add-on.
1. Start the app/add-on.
1. Open the web UI from the app/add-on page, or browse to the configured
   `50051/tcp` host port.

By default the app/add-on stores Hydris world state at `/config/world.yaml`,
which is backed by the app/add-on configuration directory.

## Configuration

Example configuration:

```yaml
world_file: /config/world.yaml
no_defaults: false
disable_local_serial: true
allow_netscan: false
disable_security: false
plugins: []
allow_paths: []
run_parameters: []
log_level: info
```

### Option: `world_file`

Path to the Hydris world-state file. Use a path under `/config` to persist data
across restarts and backups.

```yaml
world_file: /config/world.yaml
```

### Option: `no_defaults`

Start Hydris without built-in default world entities.

```yaml
no_defaults: true
```

### Option: `disable_local_serial`

Disable discovery of local serial ports. This is enabled by default because
Home Assistant app/add-on containers do not automatically receive host serial
devices.

```yaml
disable_local_serial: true
```

### Option: `allow_netscan`

Allow Hydris to scan the local network for devices.

```yaml
allow_netscan: true
```

### Option: `disable_security`

Disable Hydris policy enforcement.

```yaml
disable_security: true
```

### Option: `plugins`

Hydris plugins to run. Entries are passed as repeated `--plugin` arguments.

```yaml
plugins:
  - ghcr.io/example/hydris-plugin:latest
```

### Option: `allow_paths`

Additional filesystem paths Hydris may access.

```yaml
allow_paths:
  - /ssl
```

If you need to use `/ssl`, add an `ssl` map to `hydris/config.yaml`.

### Option: `run_parameters`

Advanced Hydris command-line flags. Each list item is passed to Hydris as a
single argument.

```yaml
run_parameters:
  - --view
```

### Option: `log_level`

Controls the wrapper log level exposed by the Home Assistant base image.

```yaml
log_level: debug
```

## Hardware Access

This app/add-on is intentionally conservative by default. If you need serial,
USB, Bluetooth, or network discovery features, review Home Assistant Supervisor
permissions and add only the required `uart`, `usb`, `devices`, `host_network`,
or privileged settings to `hydris/config.yaml`.

## Upstream

- Hydris: <https://github.com/projectqai/hydris>
- Documentation: <https://projectqai.github.io/docs>

