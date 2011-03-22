# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit subversion

DESCRIPTION="LibTorrent is a BitTorrent library written in C++ for *nix."
HOMEPAGE="http://libtorrent.rakshasa.no"
ESVN_REPO_URI="svn://rakshasa.no/libtorrent/trunk/libtorrent"
ESVN_BOOTSTRAP="autogen.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="debug ipv6"

DEPEND="${RDEPEND}
dev-util/pkgconfig"
RDEPEND=">=dev-libs/libsigc++-2.2.2"

src_unpack() {
subversion_src_unpack
}

#src_prepare() {
#epatch "${FILESDIR}"/log_files.patch
#}

src_configure() {
econf \
$(use_enable debug debug werror) \
$(use_enable ipv6)
epatch "${FILESDIR}"/log_files.patch
}

src_compile() {
emake || die "emake failed"
}

src_install() {
emake docdir="/usr/share/doc/${PN}" DESTDIR="${D}" install \
|| die "emake install failed"

dodoc AUTHORS ChangeLog README
}
