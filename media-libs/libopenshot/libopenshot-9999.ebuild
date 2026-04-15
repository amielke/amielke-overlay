# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..13} )

inherit cmake git-r3 python-single-r1 virtualx

DESCRIPTION="Video editing, animation, and playback library for C++, Python, and Ruby"
HOMEPAGE="https://github.com/OpenShot/libopenshot"
EGIT_REPO_URI="https://github.com/OpenShot/libopenshot.git"
EGIT_BRANCH="qt6-support"

LICENSE="LGPL-3+"
SLOT="0/30"
KEYWORDS=""
IUSE="doc test"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="!test? ( test )"

DEPEND="
	${PYTHON_DEPS}
	dev-lang/swig
	dev-libs/jsoncpp
	dev-libs/protobuf
	media-gfx/imagemagick[cxx]
	media-libs/babl
	media-libs/libopenshot-audio:=
	media-video/ffmpeg:=
	net-libs/cppzmq
	net-libs/zeromq
	dev-qt/qtbase
	dev-qt/qtmultimedia
	dev-qt/qtsvg
"
RDEPEND="
	${PYTHON_DEPS}
	dev-libs/jsoncpp
	dev-libs/protobuf
	media-gfx/imagemagick[cxx]
	media-libs/babl
	media-libs/libopenshot-audio:=
	media-video/ffmpeg:=
	net-libs/cppzmq
	net-libs/zeromq
	dev-qt/qtbase
	dev-qt/qtmultimedia
	dev-qt/qtsvg
"
BDEPEND="
	doc? ( app-text/doxygen )
	test? (
		dev-cpp/catch:0
		dev-cpp/unittest++
		x11-base/xorg-server[xvfb]
	)
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-DENABLE_RUBY=OFF
		-DUSE_SYSTEM_JSONCPP=ON
		-DUSE_QT6=ON
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
