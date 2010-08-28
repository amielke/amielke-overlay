# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Script pack for VDR plugin: yacoto"
HOMEPAGE="http://www.htpc-forum.de/index.php?url=downloads.php"
SRC_URI="http://www.htpc-forum.de/download/${PN}-helau-${PV}.tgz
	http://www.muresan.de/vdr/yacoto/${PN}-helau-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="3gp +dvd ipod mp3 ogg +projectx +status +x264 +xvid"

DEPEND=">=media-video/vdr-1.6.0"

RDEPEND="media-video/vdrsync
	app-misc/screen
	media-video/replex[yacoto]
	>=media-video/replex-0.1.6.8
	3gp? (	media-video/mplayer[encode]
		media-video/ffmpeg[encode] )
	dvd? (	app-cdr/cdrtools
		app-cdr/dvd+rw-tools
		media-video/vamps
		media-video/mjpegtools
		media-gfx/imagemagick
		media-video/dvdauthor )
	ipod? (	media-video/mplayer[encode]
		media-video/ffmpeg[encode]
		media-video/gpac )
	mp3? (	media-sound/lame )
	ogg? (	media-sound/lame
		media-sound/vorbis-tools )
	projectx? ( media-video/projectx )
	status? ( media-plugins/vdr-bgprocess )
	x264? (	media-video/mplayer[encode,x264=] )
	xvid? ( || (	media-video/mplayer[encode,xvid=]
			media-video/ffmpeg[encode,xvid=] ) )"

S="${WORKDIR}"/yacoto
MY_YAC_DIR="/usr/share/vdr/yacoto"
MY_YAC_CONF_DIR="/etc/vdr/plugins/yacoto"

src_prepare() {

	epatch "${FILESDIR}/${P}_customization.diff"

}

src_compile() {
	einfo "Nothing to compile"
}

src_install() {

	# internal variables controlling optional encoding profiles are set default to "1",
	# so if we do not want them, set them here to "0" before invoking the install rule
	use 3gp || OPTIONS+="WITH_3GP=0"
	use dvd || OPTIONS+=" WITH_DVD=0"
	use ipod || OPTIONS+=" WITH_IPOD=0"
	use mp3 || OPTIONS+=" WITH_MP3=0"
	use ogg || OPTIONS+=" WITH_OGG=0"
	use projectx || OPTIONS+=" WITH_PROJECTX=0"
	use x264 || OPTIONS+=" WITH_H264=0"
	use xvid || OPTIONS+=" WITH_DIVX=0"

	DESTDIR="${D}" YAC_DIR="${MY_YAC_DIR}" eval "${OPTIONS}" emake install || die "Installation of yacoto scripts failed!"

	cd "${D}${MY_YAC_CONF_DIR}"
	rename .conf.sample .conf *.conf.sample
	cd "${D}${MY_YAC_CONF_DIR}"/conf
	rename .conf.sample .conf *.conf.sample
	if use dvd; then
		cd "${D}${MY_YAC_CONF_DIR}"/conf/dvd
		rename .conf.sample .conf *.conf.sample
	fi

	prepalldocs

	keepdir ${MY_YAC_DIR}/queue
	keepdir /var/log/yacoto

}

pkg_postinst(){

	ewarn ""
	ewarn "If this is your first installation, please make sure"
	ewarn "you create an initial vdr-yacoto plugin configuration"
	ewarn "file before starting VDR!"
	ewarn ""
	ewarn "This file, located at \"${MY_YAC_CONF_DIR}/yacadmin.conf\""
	ewarn "can be generated by running"
	ewarn "\"${MY_YAC_DIR}/yac_setplgconf.sh\" after adjusting"
	ewarn "the values in \"${MY_YAC_CONF_DIR}/yacoto.conf\"."
	ewarn ""
	ewarn "You can also adjust some variables in"
	ewarn "\"${MY_YAC_CONF_DIR}/myvars.conf\"..."
	if use projectx; then
		ewarn "...and \"${MY_YAC_CONF_DIR}/conf/ProjectX.ini\"..."
	fi
	ewarn ""
	epause 5

}
