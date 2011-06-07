# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit rpm multilib eutils

DESCRIPTION="Brother DCP-7010 CUPS wrapper."
HOMEPAGE="http://solutions.brother.com/linux/en_us/index.html"
SRC_URI="http://pub.brother.com/pub/com/bsc/linux/dlf/mfcj265wcupswrapper-1.1.1-3.i386.rpm"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="fetch strip"

DEPEND="net-print/cups
        app-arch/rpm
		net-print/brother-mfc-j265w-lpr"
RDEPEND="${DEPEND}"

DOWNLOAD_URL="http://www.brother.com/cgi-bin/agreement/agreement.cgi?dlfile=http://solutions.brother.com/Library/sol/printer/linux/rpmfiles/cups_wrapper/cupswrapperDCP7010-2.0.1-1.i386.rpm&lang=English_gpl"

pkg_nofetch() {
    einfo "Please download ${A} from ${DOWNLOAD_URL}."
    einfo "Select 'I Accept' and move the file to ${DISTDIR}."
}

src_unpack() {
	rpm_unpack "${DISTDIR}/${A}" || die "Error unpacking ${A}."
}

src_install() {
	has_multilib_profile && ABI=x86
	INSTDIR="/opt/Brother"

	dodir "${INSTDIR}/cupswrapper"
	mv usr/local/Brother/cupswrapper/{brcupsconfig3,cupswrapperDCP7010-2.0.1} "${D}${INSTDIR}/cupswrapper"
}

