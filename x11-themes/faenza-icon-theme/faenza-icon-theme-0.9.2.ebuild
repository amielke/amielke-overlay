# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/faenza-icon-theme/faenza-icon-theme-0.7.ebuild,v 1.4 2011/01/26 16:52:26 ssuominen Exp $

inherit gnome2-utils

DESCRIPTION="A scalable icon theme called Faenza"
HOMEPAGE="http://code.google.com/p/faenza-icon-theme/"
SRC_URI="http://faenza-icon-theme.googlecode.com/files/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="minimal"

RDEPEND="!minimal? ( x11-themes/gnome-icon-theme )"
DEPEND="app-arch/unzip"

RESTRICT="binchecks strip"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
}

src_install() {
	insinto /usr/share/icons
	doins -r Faenza || die
	doins -r Faenza-Dark || die
	doins -r Faenza-Darker || die
	doins -r Faenza-Darkest || die

	dodoc AUTHORS ChangeLog README
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
