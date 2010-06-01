# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-fritzbox/vdr-fritzbox-1.2.1.ebuild,v 1.1 2009/06/14 10:07:51 zzam Exp $
EAPI=2

inherit vdr-plugin

DESCRIPTION="VDR Plugin: load the program guide from tvmovie to vdr"
HOMEPAGE="http://vdr-plugin-tvm2vdr.origo.ethz.ch/"
SRC_URI="http://download.origo.ethz.ch/vdr-plugin-tvm2vdr/1497/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/vdr-1.4.6"
RDEPEND="${DEPEND}"

src_install() {
	vdr-plugin_src_install
	
		insinto /etc/vdr/plugins/tvm2vdr
		doins "${S}/tvm2vdr_channelmap.conf"

		insinto /etc/vdr/plugins/tvm2vdr
		doins "${S}/tvm2vdr_getpictures.xsl"

		insinto /etc/vdr/plugins/tvm2vdr
		doins "${S}/tvm2vdr_tvmovie-iso-8859-1.xsl"

		insinto /etc/vdr/plugins/tvm2vdr
		doins "${S}/tvm2vdr_tvmovie-utf-8.xsl"

		insinto /etc/vdr/plugins/tvm2vdr
		doins "${S}/tvm2vdr_tvmovie.xsl"

}



pkg_postinst() {
vdr-plugin_pkg_postinst



}
