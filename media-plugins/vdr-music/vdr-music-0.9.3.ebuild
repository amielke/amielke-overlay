# Copyright 2003-2010 Gentoo Foundation                                                 
# Distributed under the terms of the GNU General Public License v2                      
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-music/vdr-music-0.9.3.ebuild,v 1.3 2008/06/22 17:25:17 tr500 Exp $

EAPI="2"

inherit vdr-plugin

MY_P="${P}-testing"
S="${WORKDIR}/music-${PV}-testing"

DESCRIPTION="VDR plugin: music"
HOMEPAGE="http://www.vdr.glaserei-franz.de/vdrplugins.htm"
SRC_URI="http://www.vdr.glaserei-franz.de/files/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

IUSE="+hd +truetype imagemagick vorbis graphtft sndfile debug"

PATCHES=("${FILESDIR}/0.9.x/Makefile.patch")

DEPEND=">=media-video/vdr-1.6.0
        media-libs/libmad
        media-libs/libid3tag
        vorbis? ( media-libs/libvorbis )
        imagemagick? ( media-gfx/imagemagick[png] )
        sndfile? ( media-libs/libsndfile )
        !imagemagick? ( media-libs/imlib2[png] )"

RDEPEND="sys-process/at
        graphtft? ( >=media-plugins/vdr-graphtft-0.1.5 )"

src_prepare() {
        vdr-plugin_src_prepare

        if use graphtft && use imagemagick; then
                echo
                eerror "Please use only one of this USE-Flags"
                eerror "\tgraphtft imagemagick"
                die "multiple menu manipulation"
        fi

        use graphtft && sed -i Makefile -e "s:HAVE_MAGICK=1:#HAVE_MAGICK=1:"
        use !vorbis && sed -i Makefile -e "s:#WITHOUT_LIBVORBISFILE=1:WITHOUT_LIBVORBISFILE=1:"
        use !hd && sed -i Makefile -e "s:HAVE_HD_OSD=1:#HAVE_HD_OSD=1:"
        use !sndfile && sed -i Makefile -e "s:#WITHOUT_LIBSNDFILE=1:WITHOUT_LIBSNDFILE=1:"
        use imagemagick && sed -i Makefile -e "s:#HAVE_MAGICK=1:HAVE_MAGICK=1:" && sed -i Makefile -e "s:#MAGICKDIR=/usr/include/ImageMagick:MAGICKDIR=/usr/include/ImageMagick:"
        use !truetype && sed -i Makefile -e "s:HAVE_FREETYPE=1:#HAVE_FREETYPE=1:"
        use !debug && sed -i Makefile -e "s:DEBUG=1:#DEBUG=1:"
}

src_install() {
        vdr-plugin_src_install

        insinto /etc/vdr/plugins/music
        doins -r music/*
        chown -R vdr:vdr "${D}"/etc/vdr/plugins/music

        exeinto /usr/share/vdr/music/downloads/music_cover
        doexe music/downloads/music_cover/*
        chown -R vdr:vdr "${D}"/usr/share/vdr/music
}
