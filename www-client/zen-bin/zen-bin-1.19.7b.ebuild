# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="Zen Browser - Experience tranquillity while browsing the web"
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

QA_PREBUILT="opt/zen-bin/*"

RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0:2
	dev-libs/expat
	>=dev-libs/glib-2.26:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	>=media-libs/freetype-2.4.10
	media-video/ffmpeg
	net-print/cups
	sys-apps/dbus
	virtual/freedesktop-icon-theme
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-3.24:3[X]
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libxcb
	>=x11-libs/pango-1.22.0
"

src_install() {
	local destdir="/opt/zen-bin"
	local icon size

	dodir /opt || die
	cp -a "${S}" "${ED}${destdir}" || die

	dosym -r "${destdir}/zen-bin" /usr/bin/zen || die

	for icon in "${ED}${destdir}"/browser/chrome/icons/default/default*.png; do
		[[ -f ${icon} ]] || continue
		size=${icon##*/default}
		size=${size%.png}
		newicon -s "${size}" "${icon}" zen.png || die
	done

	domenu "${FILESDIR}/zen.desktop" || die

	insinto "${destdir}/distribution"
	doins "${FILESDIR}/policies.json" || die
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
