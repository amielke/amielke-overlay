# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )

inherit cmake python-single-r1 virtualx

DESCRIPTION="Video editing, animation, and playback library for C++, Python, and Ruby"
HOMEPAGE="https://github.com/openshot/libopenshot"
SRC_URI="https://github.com/openshot/libopenshot/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

DEPEND="
	${PYTHON_DEPS}
	dev-libs/jsoncpp
	dev-libs/protobuf
	dev-lang/swig
	media-gfx/imagemagick[cxx]
	media-libs/libopenshot-audio:=
	media-video/ffmpeg:=
	net-libs/zeromq
	dev-qt/qtbase:5
	dev-qt/qtmultimedia:5
	dev-qt/qtsvg:5
"
RDEPEND="
	${PYTHON_DEPS}
	dev-libs/jsoncpp
	dev-libs/protobuf
	media-gfx/imagemagick[cxx]
	media-libs/libopenshot-audio:=
	media-video/ffmpeg:=
	net-libs/zeromq
	dev-qt/qtbase:5
	dev-qt/qtmultimedia:5
	dev-qt/qtsvg:5
"
BDEPEND="
	doc? ( app-text/doxygen )
	test? (
		dev-cpp/catch:0
		dev-cpp/unittest++
		x11-base/xorg-server[xvfb]
	)
"

PATCHES=(
	"${FILESDIR}/${PN}-protobuf-cxx17.patch"
)

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_RUBY=OFF
		-DUSE_SYSTEM_JSONCPP=ON
		-DPYTHON_EXECUTABLE="${PYTHON}"
	)

	cmake_src_configure
}

src_test() {
	local -a myctestargs=(
		-E '(Caption:caption effect|FFmpegWriter:DisplayInfo|FFmpegWriter:Options_Overloads|FFmpegWriter:Webm)'
	)

	virtx ctest "${myctestargs[@]}" --output-on-failure || die "tests failed"
}
