# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

 	inherit eutils
	
 	DESCRIPTION="Framework for biometric-based authentication"
 	HOMEPAGE="http://www.bioapi.org"
 	SRC_URI="http://www.qrivy.net/~michael/blua/${PN}/${P}.tar.bz2"
 	LICENSE="bioapi"
 	
 	SLOT="0"
 	KEYWORDS="~x86"
	IUSE="qt3"
 	
 	#DEPEND=""
 	RDEPEND="${DEPEND}
 	qt3? ( =x11-libs/qt-3* )"
 	
 	pkg_setup() {
 	ewarn "Note: this ebuild is not able to handle an upgrade correctly."
 	ewarn "Instead, remove the old bioapi installation manually, run the"
 	ewarn "instructions given at the end of the removal and restart this merge."
 	}
 	
 	src_unpack() {
 	unpack ${A}
 	}
 	
 	src_compile() {
 	myconf="
 	--host=${CHOST}\
 	--prefix=/opt/bioapi \
 	--sysconfdir=/etc \
 	--localstatedir=/var \
 	--libdir=/usr/$(get_libdir) \
 	--infodir=/usr/share/info \
 	--mandir=/usr/share/man"
 	
 	if use qt3; then
 	myconf="${myconf} --with-Qt-dir=/usr/qt/3"
 	else
 	myconf="${myconf} --without-Qt-dir"
 	fi
 	
 	econf $myconf || die "./configure failed"
 	emake || die "emake failed"
 	}
 	
 	src_install() {
 	SKIPCONFIG=true make DESTDIR=${D} install || die "install failed"
 	#and now we have to handle the docs
 	dodoc README\
 	00_License.htm \
 	01_Readme.htm \
 	09_Manifest.htm \
 	10_Build.htm \
 	11_Install.htm \
 	12_Use.htm \
 	20_Todo.htm \
 	30_History.htm \
 	31_Contributors.htm \
 	32_Contacts.htm \
 	Disclaimer
 	insinto /opt/bioapi/include
 	doins include/bioapi_util.h include/installdefs.h \
 	imports/cdsa/v2_0/inc/cssmtype.h
 	insinto /etc/env.d
 	doins ${FILESDIR}/20bioapi
 	}
 	
 	pkg_postinst() {
 	einfo "Running Module Directory Services (MDS) ..."
 	/opt/bioapi/bin/mds_install -s /usr/lib || die " MDS failure"
 	/opt/bioapi/bin/mod_install -fi /usr/lib/libbioapi100.so || die " mds bioapi100 failed"
 	/opt/bioapi/bin/mod_install -fi /usr/lib/libbioapi_dummy100.so || die " mds bioapi_dummy100 failed"
 	/opt/bioapi/bin/mod_install -fi /usr/lib/libpwbsp.so || die " mds pwbsp failed"
 	
 	if use qt3 ; then
 	/opt/bioapi/bin/mod_install -fi /usr/lib/libqtpwbsp.so || die " mds qtpwbsp failed"
 	fi
 	
 	enewgroup bioapi
 	chgrp bioapi /var/bioapi -R
	chmod g+w,o= /var/bioapi -R
 	einfo "Note: users using bioapi must be in group bioapi."
 	
 	if ! use qt3 ; then
 	einfo "For building QSample, USE qt3."
 	fi
 	}
 	
 	pkg_prerm() {
 	/opt/bioapi/bin/mod_install -fu libbioapi100.so
 	/opt/bioapi/bin/mod_install -fu libbioapi_dummy100.so
 	/opt/bioapi/bin/mod_install -fu libpwbsp.so
 	
 	if use qt3 ; then
 	/opt/bioapi/bin/mod_install -fu libqtpwbsp.so
 	fi
 	
 	einfo "You might want to remove the group bioapi."
 	einfo "You might want to remove /var/bioapi."
 	} 
