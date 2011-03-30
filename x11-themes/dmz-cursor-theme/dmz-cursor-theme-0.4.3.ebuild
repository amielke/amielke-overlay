# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tango-icon-theme/tango-icon-theme-0.8.1.ebuild,v 1.8 2008/03/21 06:18:04 drac Exp $

inherit eutils gnome2-utils

DESCRIPTION="Official cursor theme from Ubuntu Linux"
HOMEPAGE="http://www.ubuntu.com"
SRC_URI="http://archive.ubuntu.com/ubuntu/pool/main/d/dmz-cursor-theme/dmz-cursor-theme_${PV}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86 ~x86-fbsd"

RESTRICT="binchecks strip"

RDEPEND=">=x11-misc/icon-naming-utils-0.8.2
	media-gfx/imagemagick
	>=gnome-base/librsvg-2.12.3
	>=x11-themes/hicolor-icon-theme-0.9"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_install() {
	insinto /usr/share/icons
	doins -r ${WORKDIR}/${P}/DMZ* || die "install failed."
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}


