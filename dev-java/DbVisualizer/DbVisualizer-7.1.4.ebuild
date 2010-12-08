# Copyright 1999-2006 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

At=dbvis_unix_7_1_4.tar.gz

DOWNLOAD_URL="http://www.minq.se/products/dbvis/download.html"

DESCRIPTION="Minq Software's DB Visualizer (Free Version)"
HOMEPAGE="http://www.minq.se/products/dbvis/"
SRC_URI="${At}"

SLOT="0"
KEYWORDS="~x86"
LICENSE="Apache-1.1"
RESTRICT="fetch"

RDEPEND="virtual/jre"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-dbvis.patch
}

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${DOWNLOAD_URL}
	einfo "Be sure to get the 'Generic UNIX' version and move it to ${DISTDIR}"
}

src_install () {
	insinto /opt/${P}
	doins -r .install4j *
	newins ${FILESDIR}/${PV}-dbvis.png dbvis.png
	dodir /opt/${P}/jdbc
	keepdir /opt/${P}/jdbc

	insinto /usr/share/applications
	newins ${FILESDIR}/${PV}-dbvis.desktop ${P}.desktop

	fperms 0755 /opt/${P}/dbvis
	dosym /opt/${P}/dbvis /usr/bin/dbvis
}

