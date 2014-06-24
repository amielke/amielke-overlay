# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4


DESCRIPTION="Ultra Editor for Linux"
HOMEPAGE="http://www.ultraedit.com/"
SRC_URI="
	x86?      ( http://www.ultraedit.com/files/uex/Other/${P}_i386.tar.gz )
	amd64?    ( http://www.ultraedit.com/files/uex/Other/${P}_amd64.tar.gz )"

LICENSE="GPL2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="strip mirror"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dodir /opt/
	mv "${WORKDIR}/${PN}/" "${D}"/opt/
	dosym /opt/uex/bin/uex /bin/uex
	#dosym /opt/uex/share/uex/uex.desktop /usr/share/applications/uex.desktop
	#dosym /opt/uex/share/uex/ue.png /usr/share/pixmaps/ue.png
	#domenu /usr/share/applications/uex.desktop
	#newicon /usr/share/pixmaps/ue.png
}

pkg_postinst() {
	ewarn "This is free trial verion of Ultra Editor Linux"
	ewarn "Only 30 days period"
	ewarn "if you like it, got to official Web for registration"
}
