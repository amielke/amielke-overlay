# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR plugin: Yacoto - Yet Another Convert Tool"
HOMEPAGE="http://www.htpc-forum.de/index.php?url=downloads.php"
SRC_URI="http://www.htpc-forum.de/download/${P}.tgz
	http://www.muresan.de/vdr/${VDRPLUGIN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="3gp +dvd ipod mp3 ogg +projectx +status +x264 +xvid"

DEPEND=">=media-video/vdr-1.7.15
	>=media-video/yacoto-scripts-0.0.3[3gp=,dvd=,ipod=,mp3=,ogg=,projectx=,status=,x264=,xvid=]"

RDEPEND="${DEPEND}"

MY_YAC_CONF_DIR="/etc/vdr/plugins/yacoto"
MY_YAC_DIR="/usr/share/vdr/yacoto"

src_prepare() {
	# patch here to keep the patch in a form ready for up-stream
	epatch "${FILESDIR}/${P}_YAC_DIR_vcodec.diff"

	vdr-plugin_src_prepare

	# copy script conf files into sandbox for i18n generation
	mkdir -p "${WORKDIR}"/yacoto/conf
	cp ${MY_YAC_CONF_DIR}/ya*conf* "${WORKDIR}"/yacoto
	cp ${MY_YAC_DIR}/ya*conf* "${WORKDIR}"/yacoto
	cp ${MY_YAC_CONF_DIR}/conf/*.conf "${WORKDIR}"/yacoto/conf
}

src_compile() {
	# build only the plugin without i18n first, with proper YAC_CONF_DIR
	BUILD_TARGETS="libvdr-${VDRPLUGIN}.so" YAC_DIR="${MY_YAC_DIR}" vdr-plugin_src_compile

	# now build i18n, with faked YAC_CONF_DIR
	BUILD_TARGETS="i18n" YAC_CONF_DIR="${WORKDIR}"/yacoto vdr-plugin_src_compile
}
