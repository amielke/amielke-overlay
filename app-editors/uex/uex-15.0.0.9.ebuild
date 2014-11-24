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

DEPEND="media-libs/libpng:1.2"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
    unpack ${A}
	    cd ${S}
}

src_install () {
    insinto /opt/
	doins -r uex/
	insinto /usr/share/applications/
	doins ${FILESDIR}/uex.desktop
	insinto /usr/share/pixmaps
	doins uex/share/uex/ue.png
	dosym /opt/uex/bin/uex /usr/bin/uex
	fperms 0755 /opt/uex/bin/uex
	fperms 0755 /opt/uex/share/uex/ucxl/bin/ucxl
	rm uex/share/uex/uex.desktop
	rm uex/share/uex/ue.png
}


pkg_postinst() {
	ewarn "This is free trial verion of Ultra Editor Linux"
	ewarn "Only 30 days period"
	ewarn "if you like it, got to official Web for registration"
}
