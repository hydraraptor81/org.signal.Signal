# Signal Desktop

This repo hosts the flatpak version of [Signal-Desktop](https://github.com/signalapp/Signal-Desktop)

Signal-Desktop is a Private Messenger that links with your installed Android/iOS version of Signal.

Note that this is an **unofficial** redistribution, forked from flathub's
**unofficial** redistribution as well.

This fork keeps default flatpak permissions to a minimum and ensures that the
database key is not stored in plaintext

  - --socket=wayland
  - --socket=pulseaudio
  - --device=dri
  - --share=network
  - --talk-name=org.freedesktop.secrets

## Building and installing

```bash
./build.sh
```

## Options

You can set the following environment variables:

- `SIGNAL_DISABLE_GPU=1`: Disables GPU acceleration
- `SIGNAL_DISABLE_GPU_SANDBOX=1`: Disables GPU sandbox
- `SIGNAL_PASSWORD_STORE`: Selects where the database key is stored. Valid options are:
	- `gnome-libsecret` This is the default.
	- `kwallet` for kde4
	- `kwallet5` for kde5
	- `kwallet6` for kde6
	- `basic` Writes the key in plaintext to config.json.

## IMPORTANT if not you will end up with a plaintext key.

Ensure that you launch Signal twice to delete the plaintext key

You can also run to manually remove it
```bash
sed -i '/"key":/d' ~/.var/app/org.signal.Signal/config/Signal/config.json
```

Check that the key is indeed removed
```bash
cat ~/.var/app/org.signal.Signal/config/Signal/config.json
```

Before
```json
{
  "encryptedKey": "someKey",
  "key": "someKey",
  "safeStorageBackend": "gnome_libsecret"
}
```

After
```json
{
  "encryptedKey": "someKey",
  "safeStorageBackend": "gnome_libsecret"
}
```

Some useful commands if you want to reset your keyring (for gnome-libsecret)
```bash
secret-tool search application Signal
secret-tool clear application Signal
```

## Troubleshooting

GPU acceleration may be need to be disabled:

```bash
flatpak override --user --env=SIGNAL_DISABLE_GPU=1 org.signal.Signal
```

Additionally, Nvidia devices may need the GPU sandbox disabled:

```bash
flatpak override --user --env=SIGNAL_DISABLE_GPU_SANDBOX=1 org.signal.Signal
```

## Issue reporting

**Please only report issues in this repo that are specific to the flatpak version.**

Issues that can be replicated in a stable release should be reported in the [upstream repo](https://github.com/signalapp/Signal-Desktop).
Make sure, that the reported issue is **not** flatpak-related.
