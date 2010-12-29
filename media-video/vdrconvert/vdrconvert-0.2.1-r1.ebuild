# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdrconvert/vdrconvert-0.2.1-r1.ebuild,v 1.4 2007/01/15 19:08:39 hd_brummy Exp $

RESTRICT="nomirror"

inherit eutils

S=${WORKDIR}/${PN}

DESCRIPTION="Video Disk Recorder VDRconvert Script"
HOMEPAGE="http://vdrconvert.vdr-portal.de/"
SRC_URI="http://vdr.websitec.de/download/${PN}/${P}.tar.gz
		mirror://vdrfiles/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="dvd vcd divx mp3"

DEPEND=""

RDEPEND="${DEPEND}
		>=media-video/vdr-1.3.22
	    >=media-libs/imlib2-1.1.0
	    >=media-libs/libdvb-0.5.0-r1
	    >=media-libs/netpbm-10.31
	    >=media-libs/freetype-2.1.4
	    >=media-video/transcode-0.6.5
		>=media-video/vdrsync-0.1.2.2
		>=media-sound/alsa-utils-0.9.2
	    >=app-admin/sudo-1.6.5
	    >=app-cdr/cdlabelgen-0.3.0
	    >=app-cdr/dvd+rw-tools-5.13.4.7.4
		app-cdr/cdrtools
	    app-text/dos2unix
		!media-video/vdrconvert-cvs

		dvd? ( media-video/m2vrequantizer
				>=media-video/dvdauthor-0.6.0
				>=app-text/recode-3.6-r1
				>=media-gfx/gozer-0.7
				media-video/tcmplex-panteltje
				>=media-video/mjpegtools-1.6.1 )

		vcd? ( x86? ( >=media-video/vcdimager-0.7.20
					>=media-video/tosvcd-0.9-r2 ) )

		mp3? ( >=media-sound/lame-3.93.1-r2
			    >=media-sound/mpg123-0.59r-r3 )

		divx? ( >=media-video/mplayer-0.91 )"


vdr_data_dir() {

		source /etc/conf.d/vdr
		: ${VIDEO:=/var/vdr/video}
}

src_unpack() {

	vdr_data_dir
	einfo "Video - Directory is: ${VIDEO}"

	unpack ${A}
	cd ${S}

	use vcd && use amd64 && einfo "No vcd/svcd support on Amd64 Platform"

	for i in bin/*.sh ; do
	sed -i "s:\$homedir\/.vdrconvert\/vdrconvert.env:\/etc\/conf.d\/vdrconvert:" bin/*.sh
	sed -i "s:VDRCONVERTDIR\/bin:VDRCONVERTBINDIR:" bin/*.sh
	done

	epatch ${FILESDIR}/${PV}/vdrsync-path.diff
	epatch ${FILESDIR}/${PV}/${P}-chown.diff

#	error fix in sources
	rm bin/tosvcd
}

src_compile() {
:
}

src_install() {

		doinitd ${FILESDIR}/${PV}/vdrconvert

		dobin bin/*
		dobin ${FILESDIR}/${PV}/grab.sh

		insinto /usr/lib/vdr/rcscript
		doins ${FILESDIR}/${PV}/rc-vdrconvert.sh

		insinto /usr/share/vdrconvert
		doins -r share/vdrconvert/{fonts,images,pX}

		insinto /etc/conf.d/
		newins ${FILESDIR}/${PV}/vdrconvert.env vdrconvert

		insinto /etc/logrotate.d/
		doins etc/logrotate.d/vdrconvert

		insinto /etc/vdr/vdrconvert
		doins ${FILESDIR}/${PV}/vdrconvert.{global,burn,mpeg}
		use vcd && use x86 && doins ${FILESDIR}/${PV}/vdrconvert.vcd
		use mp3 && doins ${FILESDIR}/${PV}/vdrconvert.mp3
		use divx && doins ${FILESDIR}/${PV}/vdrconvert.divx
		use dvd && doins ${FILESDIR}/${PV}/vdrconvert.dvd

		insinto /etc/vdr/reccmds
		doins ${FILESDIR}/${PV}/reccmds.vdrconvert.conf

		insinto /etc/vdr/commands
		doins ${FILESDIR}/${PV}/commands.vdrconvert.conf

		keepdir /var/log/vdrconvert && fowners vdr:vdr /var/log/vdrconvert
		keepdir /var/run/vdrconvert && fowners vdr:vdr /var/run/vdrconvert
		keepdir /var/spool/vdrconvert && fowners vdr:vdr /var/spool/vdrconvert
		keepdir ${VIDEO}/.vdrconvert && fowners vdr:vdr ${VIDEO}/.vdrconvert

		fowners vdr:vdr /usr/bin/ins.sh
}

pkg_postinst() {

		echo
		einfo "Please add this line to your /etc/sudoers file"
		einfo "     vdr ALL=NOPASSWD:/etc/init.d/vdrconvert"
		echo
		ewarn "Depended media-libs/imlib2 have to compile with X support"
		einfo "USE=\"X\" emerge imlib2"
		echo
		einfo "Find all conf to edit in /etc/vdr/vdrconvert/"
		echo
		einfo "Importend, add in /etc/conf.d/vdr"
		einfo "to VDR_EXTRA_OPTIONS=\"--grab=/tmp\" "
		echo
		einfo "start your vdrconvert prozesses only on OSD"
		einfo "add vdrconvert to some runlevels will not work"
		echo
}
