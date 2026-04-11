# amielke-overlay

Gentoo overlay with additional ebuilds for software not available in the main Gentoo repository.

## Installation

### Recommended method

Install `eselect-repository` if it is not already installed:

```bash
emerge --ask app-eselect/eselect-repository
```

Add the overlay:

```bash
eselect repository add amielke-overlay git https://github.com/amielke/amielke-overlay.git
```

## Sync

Sync the overlay with Portage:

```bash
emaint sync -r amielke-overlay
```

Optional, if you use `eix`:

```bash
eix-sync
```

### Manual method

Create `/etc/portage/repos.conf/amielke-overlay.conf` with:

```ini
[amielke-overlay]
location = /var/db/repos/amielke-overlay
sync-type = git
sync-uri = https://github.com/amielke/amielke-overlay.git
auto-sync = yes
masters = gentoo
priority = 50
```

Then sync the overlay:

```bash
emaint sync -r amielke-overlay
```

## Usage

Install packages as usual with Portage:

```bash
emerge --ask category/package
```

## Notes

This overlay provides additional ebuilds for software not available in the main Gentoo repository.

It is distributed directly through Git and does not need to be listed in the official Gentoo repository list in order to work.

Some ebuilds may be experimental, under active testing, or based on upstream binary releases.

Please review ebuilds before using them on important systems.

## Issues

If you find a problem with an ebuild, please open an issue in this repository.

## Disclaimer

This overlay is provided as-is. Use it at your own risk.
