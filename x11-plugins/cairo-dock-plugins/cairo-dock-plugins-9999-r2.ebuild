# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"


# The ebuild depends on CMAKE and also the BZR revision control system
# which is used for pulling the source code from the LaunchPad repository
inherit cmake-utils bzr

# Launchpad repository where "cairo-dock-plugins" lives:
EBZR_REPO_URI="lp:cairo-dock-plug-ins"

# You can specify a certain revision from the repository here.
# Or comment it out to choose the latest ("live") revision.
#EBZR_REVISION="2242"

DESCRIPTION="Official plugins for cairo-dock"
HOMEPAGE="https://launchpad.net/cairo-dock-plug-ins/"
# Next line is not needed because the BZR repository is specified further above
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

# The next line has been stripped down somewhat from a longer version
# used in the ebuilds of other overlays.  For more info, see:
# https://bugs.launchpad.net/cairo-dock-plug-ins/+bug/922981/comments/8
IUSE="alsa exif gmenu terminal vala webkit xfce xgamma xklavier"

# Installation instructions (from BZR source) and dependencies are listed here:
# http://glx-dock.org/ww_page.php?p=From%20BZR&lang=en

RDEPEND="
	~x11-misc/cairo-dock-${PV}
	x11-libs/cairo
	gnome-base/librsvg
	dev-libs/libxml2
	alsa? ( media-libs/alsa-lib )
	exif? ( media-libs/libexif )
	gmenu? ( gnome-base/gnome-menus )
	terminal? ( x11-libs/vte )
	webkit? ( >=net-libs/webkit-gtk-1.0 )
	xfce? ( xfce-base/thunar )
	xgamma? ( x11-libs/libXxf86vm )
	xklavier? ( x11-libs/libxklavier )
	vala? ( dev-lang/vala:0.12 )
"

DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig
	dev-libs/libdbusmenu:3[gtk]
"

pkg_setup()
{
	ewarn ""
	ewarn ""
	ewarn "You are installing from a LIVE EBUILD, NOT AN OFFICIAL RELEASE."
	ewarn "   Thus, it may FAIL to build properly."
	ewarn ""
	ewarn "This ebuild is not supported by a Gentoo developer."
	ewarn "   So, please do NOT report bugs to Gentoo's bugzilla."
	ewarn "   Instead, report all bugs to write2david@gmail.com"
	ewarn ""
	ewarn ""
}

src_prepare() {
	bzr_src_prepare
}


src_configure() {

	# Next line added because of the same issues/solution as reported on...
	# ... http://glx-dock.org/bg_topic.php?t=5733

	# Where to put this variable declaration was inspired from...
	# http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/x11-libs/cairo/cairo-0.1.18.ebuild?hideattic=0&view=markup
	# However, adding this to "configure" not "compile" because the error show
	# up during configure stage.


	# Next line added because of the same issues/solutions reported on...
	# ... # https://bugs.launchpad.net/cairo-dock-plug-ins/+bug/922981
	# 
	# With a solution inspired on...
	# http://code.google.com/p/rion-overlay/source/browse/x11-misc/cairo-dock-plugins/cairo-dock-plugins-2.3.9999.ebuild?spec=svn71d4acbbb8c297b818ff886fb5dd434a6f54c377&r=71d4acbbb8c297b818ff886fb5dd434a6f54c377

	# Some more info...  http://www.cmake.org/Wiki/CMake_Useful_Variables


	# Adding the "-DLIB_SUFFIX" flag b/c https://bugs.launchpad.net/cairo-dock-core/+bug/1073734	

	mycmakeargs="${mycmakeargs} -DROOT_PREFIX=${D} -DCMAKE_INSTALL_PREFIX=/usr -DLIB_SUFFIX="
	cmake-utils_src_configure
}

pkg_postinst() {
	ewarn ""
	ewarn ""
	ewarn "You have installed from a LIVE EBUILD, NOT AN OFFICIAL RELEASE."
	ewarn "   Thus, it may FAIL to run properly."
	ewarn ""
	ewarn "This ebuild is not supported by a Gentoo developer."
	ewarn "   So, please do NOT report bugs to Gentoo's bugzilla."
	ewarn "   Instead, report all bugs to write2david@gmail.com"
	ewarn ""
	ewarn ""
}
