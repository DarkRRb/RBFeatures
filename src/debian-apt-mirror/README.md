
# Debian APT mirror (debian-apt-mirror)

Modify the source of Debian's APT

## Example Usage

```json
"features": {
    "ghcr.io/DarkRRb/RBFeatures/debian-apt-mirror:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| https | Whether to use https | boolean | false |
| host | The host of the source | string | deb.debian.org |
| spath | The path of the source | string | /debian |
| security | Whether to overwrite the security source | boolean | false |
| contrib | Whether to use contrib | boolean | true |
| non-free | Whether to use non-free | boolean | true |
| non-free-firmware | Whether to use non-free-firmware | boolean | true |



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/DarkRRb/RBFeatures/blob/main/src/debian-apt-mirror/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
