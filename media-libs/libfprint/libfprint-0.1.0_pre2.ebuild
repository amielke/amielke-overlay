# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit base

MY_PV="${PV/_/-}"

DESCRIPTION="Library to work with varios fingerprint readers"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI="mirror://sourceforge/fprint/${PN}-${MY_PV}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libusb
	media-gfx/imagemagick"

PATCHES=(
		"${FILESDIR}/0001-Add-some-corrective-action-if-there-are-missing-pack.patch"
		"${FILESDIR}/0001-Fix-a-segfault-that-occured-if-a-scan-was-shorter-th-0001.patch"
		"${FILESDIR}/0002-Make-the-2-right-shift-correction-happen-on-image-ha.patch"
		"${FILESDIR}/0001-Dont-consider-the-scan-complete-unless-there-is-atle.patch"
		"${FILESDIR}/0002-upexonly.c-Fix-a-vertical-distortion-in-image-data.patch"
		"${FILESDIR}/0003-the-upeke2-driver-that-supports-the-TCRD4C.patch"
		"${FILESDIR}/0004-Left-out-the-part-nuking-the-id-in-the-upeksonly-driver.patch"
		"${FILESDIR}/0005-Revised-patch-to-address-upeke2-driver.patch"
		"${FILESDIR}/0006-Revised-patch-to-address-addition-of-upeke2-driver.patch"
)

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	emake DESTDIR="${D}" install
}

