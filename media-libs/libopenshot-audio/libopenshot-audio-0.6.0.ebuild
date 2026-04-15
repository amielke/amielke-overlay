# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="High-quality audio editing and playback library used by libopenshot"
HOMEPAGE="https://github.com/openshot/libopenshot-audio"
SRC_URI="https://github.com/openshot/libopenshot-audio/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0/10"
KEYWORDS="~amd64"
IUSE="doc test"

RESTRICT="!test? ( test )"

DEPEND="
	media-libs/alsa-lib
	virtual/zlib
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	doc? ( app-text/doxygen )
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
	)

	cmake_src_configure
}
