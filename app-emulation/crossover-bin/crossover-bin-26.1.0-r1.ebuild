# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
PYTHON_COMPAT=( python3_{11..13} )

inherit python-single-r1 unpacker

DESCRIPTION="Commercial version of app-emulation/wine with paid support"
HOMEPAGE="https://www.codeweavers.com/products/"
SRC_URI="https://media.codeweavers.com/pub/crossover/cxlinux/demo/install-crossover-${PV}.bin"

S="${WORKDIR}"

LICENSE="CROSSOVER-3"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+capi +cups +gphoto2 +gstreamer +jpeg +lcms +mp3 +nls +openal +opencl +opengl +pcap +png +scanner +ssl +v4l +vulkan"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="bindist test"
QA_PREBUILT="opt/cxoffice/*"

BDEPEND="${PYTHON_DEPS}
	app-arch/unzip
	dev-lang/perl
"

RDEPEND="${DEPEND}
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/dbus-python[${PYTHON_USEDEP}]
		dev-python/pycairo[${PYTHON_USEDEP}]
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	!prefix? ( sys-libs/glibc )
	capi? ( net-libs/libcapi[abi_x86_32(-)] )
	cups? ( net-print/cups[abi_x86_32(-)] )
	jpeg? ( media-libs/libjpeg-turbo:0[abi_x86_32(-)] )
	lcms? ( media-libs/lcms:2 )
	gphoto2? ( media-libs/libgphoto2[abi_x86_32(-)] )
	gstreamer? (
		media-libs/gstreamer:1.0[abi_x86_32(-)]
		jpeg? ( media-plugins/gst-plugins-jpeg:1.0[abi_x86_32(-)] )
		media-plugins/gst-plugins-meta:1.0[abi_x86_32(-)]
	)
	mp3? ( >=media-sound/mpg123-1.5.0[abi_x86_32(-)] )
	nls? ( sys-devel/gettext[abi_x86_32(-)] )
	openal? ( media-libs/openal[abi_x86_32(-)] )
	opencl? ( virtual/opencl[abi_x86_32(-)] )
	opengl? (
		virtual/glu[abi_x86_32(-)]
		virtual/opengl[abi_x86_32(-)]
	)
	pcap? ( net-libs/libpcap[abi_x86_32(-)] )
	png? ( media-libs/libpng:0[abi_x86_32(-)] )
	scanner? ( media-gfx/sane-backends[abi_x86_32(-)] )
	ssl? ( net-libs/gnutls:0/30.30[abi_x86_32(-)] )
	v4l? ( media-libs/libv4l[abi_x86_32(-)] )
	vulkan? ( media-libs/vulkan-loader[abi_x86_32(-)] )
	dev-libs/glib:2
	>=dev-libs/gobject-introspection-1.82.0-r2
	dev-libs/openssl-compat:1.1.1
	dev-util/desktop-file-utils
	media-libs/alsa-lib[abi_x86_32(-)]
	media-libs/freetype:2[abi_x86_32(-)]
	media-libs/mesa[abi_x86_32(-)]
	media-libs/tiff-compat:4[abi_x86_32(-)]
	sys-auth/nss-mdns[abi_x86_32(-)]
	sys-apps/pcsc-lite[abi_x86_32(-)]
	sys-apps/util-linux[abi_x86_32(-)]
	sys-libs/libunwind[abi_x86_32(-)]
	sys-libs/libxcrypt[compat]
	sys-libs/ncurses-compat:5[abi_x86_32(-)]
	virtual/zlib:=[abi_x86_32(-)]
	x11-libs/gdk-pixbuf:2[introspection]
	x11-libs/gtk+:3[introspection]
	x11-libs/libICE[abi_x86_32(-)]
	x11-libs/libSM[abi_x86_32(-)]
	x11-libs/libX11[abi_x86_32(-)]
	x11-libs/libXau[abi_x86_32(-)]
	x11-libs/libXcursor[abi_x86_32(-)]
	x11-libs/libXdmcp[abi_x86_32(-)]
	x11-libs/libXext[abi_x86_32(-)]
	x11-libs/libXi[abi_x86_32(-)]
	x11-libs/libXrandr[abi_x86_32(-)]
	x11-libs/libXxf86vm[abi_x86_32(-)]
	x11-libs/libxcb[abi_x86_32(-)]
	x11-libs/pango[introspection]
	x11-libs/vte:2.91[introspection]
"

src_unpack() {
	# Self-unpacking zip archive; unzip warns about the embedded executable payload.
	unpack_zip ${A}
}

src_prepare() {
	default

	# Remove unnecessary files; license.txt is kept because it is referenced
	# by multiple installed files, including menu integration.
	if [[ -d guis ]]; then
		rm -r guis || die "Could not remove guis/"
	fi
}

src_install() {
	sed -i \
		-e "s:xdg_install_icons(:&\"${ED}\".:" \
		-e "s:\"\(.*\)/applications:\"${ED}\1/applications:" \
		-e "s:\"\(.*\)/desktop-directories:\"${ED}\1/desktop-directories:" \
		"${S}/lib/perl/CXMenuXDG.pm" || die

	# Install crossover symlink, bug #476314
	dosym ../cxoffice/bin/crossover /opt/bin/crossover

	# Install documentation
	dodoc README changelog.txt
	rm -f README changelog.txt || die "Could not remove bundled docs"

	# Install payload
	dodir /opt/cxoffice
	cp -a "${S}"/. "${ED}/opt/cxoffice/" || die "Could not install into ${ED}/opt/cxoffice"

	# Disable auto-update
	sed -i -e 's/;;\"AutoUpdate\" = \"1\"/\"AutoUpdate\" = \"0\"/g' \
		share/crossover/data/cxoffice.conf || die

	# Install configuration file
	insinto /opt/cxoffice/etc
	doins share/crossover/data/cxoffice.conf
	dodir /etc/env.d
	echo "CONFIG_PROTECT=/opt/cxoffice/etc/cxoffice.conf" >> "${ED}"/etc/env.d/30crossover-bin || die

	# Konqueror may try to open files for writing, which causes sandbox
	# violations. Force the check to false temporarily.
	sed -i -e 's/cxwhich konqueror/false &/' \
		"${ED}/opt/cxoffice/bin/locate_gui.sh" || die "Could not apply workaround for konqueror"

	# Install menus
	# XXX: locate_gui.sh automatically detects *-application-merged directories.
	# This means the installed result can vary with /etc/xdg contents, which is
	# a QA violation. It is not clear how to resolve this cleanly.
	XDG_DATA_HOME="/usr/share" XDG_CONFIG_HOME="/etc/xdg" \
		"${ED}/opt/cxoffice/bin/cxmenu" --destdir="${ED}" --crossover --install \
		|| die "Could not install menus"

	# Revert temporary Konqueror workaround
	sed -i -e 's/false \(cxwhich konqueror\)/\1/' \
		"${ED}/opt/cxoffice/bin/locate_gui.sh" || die "Could not revert workaround for konqueror"

	# Drop uninstall menus if they were generated
	local uninstall_desktop=( "${ED}"/usr/share/applications/*Uninstall* )
	if [[ -e ${uninstall_desktop[0]} ]]; then
		rm -f "${uninstall_desktop[@]}" || die "Could not remove uninstall menus"
	fi

	# Fix paths
	sed -i \
		-e "s:\"${ED}\".::" \
		-e "s:${ED}::" \
		"${ED}/opt/cxoffice/lib/perl/CXMenuXDG.pm" \
		|| die "Could not fix paths in ${ED}/opt/cxoffice/lib/perl/CXMenuXDG.pm"

	local crossover_desktop=( "${ED}"/usr/share/applications/*CrossOver.desktop )
	if [[ -e ${crossover_desktop[0]} ]]; then
		sed -i -e "s:${ED}::" "${crossover_desktop[@]}" \
			|| die "Could not fix paths of desktop files"
	fi

	# Remove libs that link to opencl
	if ! use opencl; then
		rm -f "${ED}"/opt/cxoffice/lib/wine/{i386,x86_64}-unix/opencl.so || die
	fi
}
