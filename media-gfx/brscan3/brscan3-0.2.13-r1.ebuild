# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit rpm

DESCRIPTION="Brother's brscan3 scanner driver (amd64 version)"
HOMEPAGE="http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/download_scn.html#brscan3"
SRC_URI="
	x86? ( brscan3-0.2.13-1.i386.rpm )
	amd64? ( brscan3-0.2.13-1.x86_64.rpm )
"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="fetch strip"
DOWNLOAD_URL="
	x86? (
	http://www.brother.com/cgi-bin/agreement/agreement.cgi?dlfile=http://www.brother.com/pub/bsc/linux/dlf/brscan3-0.2.13-1.i386.rpm&lang=English_sane )
	amd64? (
	http://www.brother.com/cgi-bin/agreement/agreement.cgi?dlfile=http://www.brother.com/pub/bsc/linux/dlf/brscan3-0.2.13-1.x86_64.rpm&lang=English_gpl )
"

DEPEND=""
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
	einfo "To be able to scan as a non-root user, add the following line to your
	udev configuration:"
	einfo "ATTRS{idVendor}==\"04f9\", MODE=\"0666\", ENV{libsane_matched}=\"yes\""
	echo
	einfo "For network scanning, please follow the instructions on"
	einfo "http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/instruction_scn1b.html"
	echo
	einfo "If your scan application does not find the device after that, add
	\"brother3\" to /etc/sane.d/dll.conf"
	echo
}

