# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

RESTRICT="mirror strip"

inherit vdr-plugin git

EGIT_REPO_URI="https://github.com/pipelka/vdr-plugin-vnsiserver"
EGIT_PROJECT="xbmc"

DESCRIPTION="VDR plugin: VNSI Streamserver Plugin"
HOMEPAGE="http://xbmc.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.7.14"
RDEPEND="${DEPEND}"

src_unpack() {
		git_src_unpack
		cd "${WORKDIR}"
#		mv vnsiserver-9999/xbmc/pvrclients/vdr-vnsi/vdr-plugin-vnsiserver .
		mv vnsi-9999/xbmc/pvrclients/vdr-vnsi/vdr-plugin-vnsiserver .
		S="${WORKDIR}/vdr-plugin-vnsiserver/"
}

src_prepare() {
		vdr-plugin_src_prepare

		sed -i 's/vnsi-server/vnsiserver/g' config.h || die 'sed failed'

		fix_vdr_libsi_include recplayer.c
		fix_vdr_libsi_include receiver.c
}

src_install() {
		vdr-plugin_src_install

		insinto /etc/vdr/plugins/vnsiserver
		doins vnsiserver/allowed_hosts.conf
		doins vnsiserver/noSignal.mpg
		diropts -gvdr -ovdr
}
