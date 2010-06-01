# Copyright 2003-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-music/vdr-music-0.2.0.ebuild,v 1.3 2008/06/22 17:25:17 tr500 Exp $

inherit vdr-plugin

MY_PV="${PV%_beta*}"
MY_P="${PN}-${MY_PV}-b3"
S="${WORKDIR}/music-${MY_PV}-b3"


DESCRIPTION="VDR plugin: music"
HOMEPAGE="http://www.glaserei-franz.de/VDR/Moronimo2/vdrplugins.htm"
SRC_URI="http://www.glaserei-franz.de/VDR/Moronimo2/files/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

IUSE="imagemagick debug vorbis oss graphtft 4mb-mod sndfile"


PATCHES=("${FILESDIR}/${MY_P}-Makefile.diff
	${FILESDIR}/${MY_P}-icons.diff
	${FILESDIR}/${MY_P}-gcc-4.3.diff")

DEPEND=">=media-video/vdr-1.6.0
	media-libs/libmad
	media-libs/libid3tag
	imagemagick? ( media-gfx/imagemagick )
	vorbis? ( media-libs/libvorbis )
	sndfile? ( media-libs/libsndfile )
	oss? ( media-libs/alsa-oss )
	!imagemagick? ( media-libs/imlib2 )"

RDEPEND="dev-java/blackdown-jre
	media-fonts/vdr-music-symbols-font
	>=media-plugins/vdr-span-0.0.7
	media-tv/shoutcast2vdr
	sys-process/at
	graphtft? ( >=media-plugins/vdr-graphtft-0.1.5 )"

pkg_setup() {

	use imagemagick && local LIB="media-gfx/imagemagick"
	use !imagemagick && local LIB="media-libs/imlib2"

		if ! built_with_use $LIB png; then
			echo
			eerror "Please recompile $LIB with"
			eerror "USE=\"png\""
			die "$LIB need png support"
		fi

	vdr-plugin_pkg_setup
}

src_unpack() {
	vdr-plugin_src_unpack

	if use graphtft && use imagemagick; then
		echo
		eerror "Please use only one of this USE-Flags"
		eerror "\tgraphtft imagemagick"
		die "multiple menu manipulation"
	fi

	use graphtft && sed -i Makefile -e "s:HAVE_MAGICK=1:#HAVE_MAGICK=1:"
	use !vorbis && sed -i Makefile -e "s:#WITHOUT_LIBVORBISFILE=1:WITHOUT_LIBVORBISFILE=1:"
	use !sndfile && sed -i Makefile -e "s:#WITHOUT_LIBSNDFILE=1:WITHOUT_LIBSNDFILE=1:"
	use !imagemagick && sed -i Makefile -e "s:HAVE_MAGICK=1:#HAVE_MAGICK=1:"
	use !oss && sed -i Makefile -e "s:WITH_OSS_OUTPUT=1:#WITH_OSS_OUTPUT=1:"
	use 4mb-mod && sed -i Makefile -e "s:#HAVE_OSDMOD=1:HAVE_OSDMOD=1:"
	use debug && sed -i Makefile -e "s:#DBG=1:DBG=1:"
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/music
	doins music/musicsources.conf

	insinto /etc/vdr/plugins/music/fonts
	doins -r music/fonts/*

	insinto /etc/vdr/plugins/music/coverviewer
	doins -r music/coverviewer/*

	insinto /etc/vdr/plugins/music/data
	doins -r music/data/*

	exeinto /usr/share/vdr/music/downloads/music_cover
	doexe music/downloads/music_cover/*

	insinto /etc/vdr/plugins/music/playlists
	doins music/playlists/*

	insinto /etc/vdr/plugins/music/themes
	doins -r music/themes/*

	for i in $(ls music/language)
	do
		if [ -d "music/language/${i}/data" ]; then
			insinto /etc/vdr/plugins/music/language/${i}
		doins -r music/language/${i}/*
		fi
	done

	insinto /etc/vdr/plugins/music/visual
	doins -r music/visual/*

	keepdir /etc/vdr/plugins/music/downloads/music_cover

	keepdir /etc/vdr/plugins/music/scripts

	keepdir /etc/vdr/plugins/music/lyrics
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	echo
	elog "To complete your media-plugins/vdr-music install"
	elog "take a look on:"
	echo
	elog "media-plugins/vdr-coverviewer"
	elog "media-plugins/vdr-picselshow"
	echo
	elog " Please change your /etc/vdr/plugins/music/musicsources.conf "
	echo
}
