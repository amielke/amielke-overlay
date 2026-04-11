# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg-utils

DESCRIPTION="Zen Browser - A fast, privacy-focused Firefox fork"
HOMEPAGE="https://zen-browser.app/"
SRC_URI="
    amd64? ( https://github.com/zen-browser/desktop/releases/download/${PV}/zen.linux-x86_64.tar.xz -> ${P}-amd64.tar.xz )
    arm64? ( https://github.com/zen-browser/desktop/releases/download/${PV}/zen.linux-aarch64.tar.xz -> ${P}-arm64.tar.xz )
"
S="${WORKDIR}/zen"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="strip"
QA_PREBUILT="*"

RDEPEND="
    dev-libs/glib:2
    dev-libs/nspr
    dev-libs/nss
    media-libs/alsa-lib
    media-libs/fontconfig
    media-libs/freetype
    x11-libs/gtk+:3
"

DEPEND=""

src_install() {
    local destdir="/usr/lib64/zen"

    # Install directories
    insinto "${destdir}"
    doins -r browser
    doins -r defaults
    doins -r fonts
    doins -r gmp-clearkey
    doins -r icons

    # Install top-level files
    doins application.ini
    doins dependentlibs.list
    doins platform.ini
    doins precomplete
    doins removed-files
    doins update-settings.ini
    doins updater.ini
    doins omni.ja

    # Install binaries
    exeinto "${destdir}"
    doexe glxtest
    doexe pingsender
    doexe updater
    doexe vaapitest
    doexe zen
    doexe zen-bin

    # Install shared libs
    doexe lib*.so

    # Symlink
    dosym -r /usr/lib64/zen/zen-bin /usr/bin/zen || die

    # Icons
    local size
    for size in 16 32 48 64 128; do
        newicon -s ${size} "browser/chrome/icons/default/default${size}.png" zen.png
    done

    # Desktop file
    domenu "${FILESDIR}/zen.desktop"

    # Policies
    insinto "${destdir}/distribution"
    doins "${FILESDIR}/policies.json"
}

pkg_postinst() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}

pkg_postrm() {
    xdg_desktop_database_update
    xdg_icon_cache_update
}
