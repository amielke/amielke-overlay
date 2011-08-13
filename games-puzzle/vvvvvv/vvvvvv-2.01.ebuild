# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games

MY_PN="VVVVVV"
DESCRIPTION="A 2D puzzle platform video game"
HOMEPAGE="http://thelettervsixtim.es"

MAIN_PKG="${MY_PN}_${PV}_Linux.tar.gz"
FIX_PKG="http://www.machinestudios.co.uk/${MY_PN}/${MY_PN}_Linux.tar.gz"
SRC_URI="${MAIN_PKG} ${FIX_PKG}"

RESTRICT="fetch strip"
LICENSE=""

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl[audio,joystick,video]
         media-libs/sdl-image
         media-libs/sdl-mixer[vorbis]"

S="${WORKDIR}/${MY_PN}"

GAMEDIR="${GAMES_PREFIX_OPT}/${PN}"

pkg_nofetch() {
	if [[ ! -r "${DISTDIR}/${MAIN_PKG}" ]]
	then
		einfo ""
		einfo "Please buy and download \"${MAIN_PKG}\" from:"
		einfo "  ${HOMEPAGE}"
		einfo "and move/link it to \"${DISTDIR}\""
	fi

	# We can't restrict fetch for only one file, sorry:
	if [[ ! -r "${DISTDIR}/${FIX_PKG}" ]]
	then
		einfo ""
		einfo "Please manually download \"$(basename ${FIX_PKG})\" from:"
		einfo "  ${FIX_PKG}"
		einfo "and move/link it to \"${DISTDIR}\""
	fi
	einfo ""
}

src_prepare() {
	REMOVE="LIB*
		${MY_PN}*"

	for remove in ${REMOVE}
	do
		rm -r "${S}/${remove}" || die "rm \"${remove}\" failed"
	done
}

src_install() {
	insinto "${GAMEDIR}" || die "insinto \"${GAMEDIR}\" failed"
	doins -r "data" || die "doins \"data\" failed"

	exeinto "${GAMEDIR}" || die "exeinto \${GAMEDIR}\" failed"
	if use amd64
	then
		newexe "../${MY_PN}_64" "${PN}" || die "newexe \"${MY_PN}_64\" failed"
	fi
	if use x86
	then
		newexe "../${MY_PN}_32" "${PN}" || die "newexe \"${MY_PN}_32\" failed"
	fi

	# Make game wrapper
	games_make_wrapper "${PN}" "./${PN}" "${GAMEDIR}" || die "games_make_wrapper \"./${PN}\" failed"

	# Install icon and desktop file
	newicon "data/icons/32_2.png" "${PN}.png" || die "newicon \"${PN}.png\" failed"
	make_desktop_entry "${PN}" "${MY_PN}" "/usr/share/pixmaps/${PN}.png" || die "make_desktop_entry failed"

	# Setting permissions
	prepgamesdirs
}

pkg_postinst() {
	echo ""
	games_pkg_postinst
}

