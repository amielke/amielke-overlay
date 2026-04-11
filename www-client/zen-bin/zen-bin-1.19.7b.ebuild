# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

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

QA_PREBUILT="
    /usr/lib64/zen/*.so
    /usr/lib64/zen/zen-bin
    /usr/lib64/zen/zen
    /usr/lib64/zen/updater
    /usr/lib64/zen/pingsender
    /usr/lib64/zen/glxtest
    /usr/lib64/zen/vaapitest
"

RDEPEND="
    dev-libs/glib:2
    dev-libs/nspr
    dev-libs/nss
    media-libs/alsa-lib
    media-libs/fontconfig
    media-libs/freetype
    media-libs/libpng
    x11-libs/cairo
    x11-libs/pango
    x11-libs/libX11
    x11-libs/libXcomposite
    x11-libs/libXdamage
    x11-libs/libXext
    x11-libs/libXfixes
    x11-libs/libXrender
    x11-libs/libXtst
    x11-libs/libXrandr
    x11-libs/libxcb
    sys-apps/dbus
    net-print/cups
    media-libs/mesa
    x11-libs/gtk+:3
"

src_prepare() {
    default

    # Remove auto-updater (Gentoo policy)
    rm -f updater updater.ini precomplete removed-files || die
}

src_install() {
    local destdir="/usr/lib64/zen"

    insinto "${destdir}"
    doins -r .

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
    xdg_pkg_postinst
}

pkg_postrm() {
    xdg_pkg_postrm
}
