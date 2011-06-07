# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit rpm

DESCRIPTION="Brother MFC-7440N CUPS wrapper"
HOMEPAGE="http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/download_prn.html#MFC-7440N"
SRC_URI="mfcj265wcupswrapper-1.1.1-3.i386.rpm"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="fetch strip"
DOWNLOAD_URL="http://pub.brother.com/pub/com/bsc/linux/dlf/mfcj265wcupswrapper-1.1.1-3.i386.rpm"

DEPEND="
	app-text/a2ps
	net-print/brother-mfc-j265w-lpr
"
RDEPEND="${DEPEND}"

pkg_nofetch() {
	einfo "Please download ${A} from ${DOWNLOAD_URL}."
	einfo "Select 'I Accept' and move the file to ${DISTDIR}."
}

src_unpack() {
	rpm_unpack || die "Error unpacking ${A}."
}

src_install() {
	cp -r $WORKDIR $D
	mv $D/work/* $D
	rm -r $D/work/
}

pkg_postinst() {
	echo
	einfo "If you can't print, create the following symlink:"
	einfo "ln -s /usr/lib/cups/filter/brlpdwrapperMFCJ265W
	/usr/libexec/cups/filter/brlpdwrapperMFCJ265W"
	echo
}

