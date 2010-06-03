# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libwww/libwww-5.4.0-r7.ebuild,v 1.13 2007/07/12 10:21:05 uberlord Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"
inherit eutils multilib autotools

PATCHVER="1.0"
MY_P=w3c-${P}
DESCRIPTION="A general-purpose client side WEB API"
HOMEPAGE="http://www.w3.org/Library/"
SRC_URI="http://www.w3.org/Library/Distribution/${MY_P}.tgz
	mirror://gentoo/${P}-patches-${PATCHVER}.tar.bz2"

LICENSE="W3C"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="mysql ssl webdav regex X"

RDEPEND=">=sys-libs/zlib-1.1.4
	mysql? ( virtual/mysql )
	ssl? ( >=dev-libs/openssl-0.9.6 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-lang/perl"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -f configure.in
#	disabling examples changes nothing after the build 
#	(they aren't installed anyhow) and fixes tons of stuff by simply not going
#	through the hell of compiling things that won't work anyhow because they
#	were created to test stuff we blew away with --disable or --without
#	not to mention the fact that it's wasted build time anyhow...
#	patch disable-examples takes care of this nicely
#	see bug #246978 for more info - SkyLeach
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patch
	eautoreconf || die "autoreconf failed"
}

src_compile() {
	local myconf

#	at some point we should really check for the static flag, but for now we
#	don't want to break stuff. disabling zlib breaks everything, so set it per force
	myconf=" --enable-shared --enable-static --with-zlib"

#	let the configure script find the system libs EXPEREMENTAL
#		myconf="--with-mysql=/usr/$(get_libdir)/mysql/libmysqlclient.a"

#	test this stuff later
#	#nonagle -> special --disable case
#	if use nonagle ; then
#		myconf="${myconf} --disable-nagle"
#	fi
#
#	#nopipelining -> special --disable case
#	if use nopipelining ; then
#		myconf="${myconf} --disable-pipelining"
#	fi

#	needs patch for linking against dante
#	if use socks5 ; then
#		myconf="${myconf} --with-socks"
#	fi

	myconf="${myconf} \
		$(use_with webdav dav) \
		$(use_with X x) \
		$(use_with mysql) \
		$(use_with regex) \
		$(use_with ssl)"
#		$(use_enable static) \ - don't trust this yet, too much may depend on it

#		enabling socks requires dante... i think
#		$(use_with socks4 socks) \
#		$(use_with socks5 socks) \

# this is pulled in no matter what we do aparently, unless we say
# --without-expat  in which case the build blows up.  Nice.
#		$(use_with expat) \

# appears to break if we unset it
#		$(use_with md5) \

# doing this doesn't work right now, more research needed if wanted
#		$(use_enable posix) \

#I simply didn't have time to test this stuff because there were so many other
#issues.  Feel free if you have time on the next revision.
#		$(use_enable cryillic) \
#		$(use_enable reentrant) \
#		$(use_enable mux) \
#		$(use_with wais) \
#		$(use_enable autorules) \
#		$(use_enable extensions) \
#		$(use_enable signals) \
	export ac_cv_header_appkit_appkit_h=no
	econf ${myconf} || die "./configure failed"
	emake -j1 || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc ChangeLog
	dohtml -r .
}

