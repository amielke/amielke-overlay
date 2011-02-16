# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

inherit eutils flag-o-matic toolchain-funcs libtool mercurial

: ${EHG_REPO_URI:=http://hg.debian.org/hg/xine-lib/xine-lib-1.2}

DESCRIPTION="Core libraries for Xine movie player || xine-lib-1.2 || HG Version"
HOMEPAGE="http://hg.debian.org/hg/xine-lib/xine-lib-1.2/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 ~x86"

IUSE="aalib libcaca arts esd win32codecs nls dvd X directfb vorbis alsa
gnome sdl speex theora ipv6 altivec opengl aac fbcon xv xvmc
samba dxr3 vidix mng flac oss v4l xinerama vcd a52 mad imagemagick dts
debug modplug gtk pulseaudio mmap truetype wavpack musepack xcb jack
real vdr vdpau"

RDEPEND="X? ( x11-libs/libXext
x11-libs/libX11 )
xv? ( x11-libs/libXv )
xvmc? ( x11-libs/libXvMC )
xinerama? ( x11-libs/libXinerama )
win32codecs? ( >=media-libs/win32codecs-0.50 )
esd? ( media-sound/esound )
dvd? ( >=media-libs/libdvdcss-1.2.7 )
arts? ( kde-base/arts )
alsa? ( media-libs/alsa-lib )
aalib? ( media-libs/aalib )
directfb? ( >=dev-libs/DirectFB-0.9.9 )
gnome? ( >=gnome-base/gnome-vfs-2.0 )
flac? ( >=media-libs/flac-1.1.2 )
sdl? ( >=media-libs/libsdl-1.1.5 )
dxr3? ( >=media-libs/libfame-0.9.0 )
vorbis? ( media-libs/libogg media-libs/libvorbis )
theora? ( media-libs/libogg media-libs/libvorbis >=media-libs/libtheora-1.0_alpha6 )
speex? ( media-libs/libogg media-libs/libvorbis media-libs/speex )
libcaca? ( >=media-libs/libcaca-0.99_beta1 )
samba? ( net-fs/samba )
mng? ( media-libs/libmng )
vcd? ( media-video/vcdimager )
a52? ( >=media-libs/a52dec-0.7.4-r5 )
mad? ( media-libs/libmad )
imagemagick? ( media-gfx/imagemagick )
dts? ( || ( media-libs/libdca media-libs/libdts ) )
>=media-video/ffmpeg-0.4.9_p20070129
modplug? ( media-libs/libmodplug )
nls? ( virtual/libintl )
gtk? ( =x11-libs/gtk+-2* )
pulseaudio? ( media-sound/pulseaudio )
truetype? ( =media-libs/freetype-2* media-libs/fontconfig )
virtual/libiconv
wavpack? ( >=media-sound/wavpack-4.31 )
musepack? ( media-sound/musepack-tools )
xcb? ( >=x11-libs/libxcb-1.0 )
jack? ( >=media-sound/jack-audio-connection-kit-0.100 )
real? (
x86? ( media-libs/win32codecs )
x86-fbsd? ( media-libs/win32codecs )
amd64? ( media-libs/amd64codecs ) )"

DEPEND="${RDEPEND}
X? ( x11-libs/libXt
x11-proto/xproto
x11-proto/videoproto
x11-proto/xf86vidmodeproto
xinerama? ( x11-proto/xineramaproto ) )
v4l? ( virtual/os-headers )
dev-util/pkgconfig
sys-devel/libtool
=sys-devel/automake-1.9.6-r3
nls? ( sys-devel/gettext )"

S="${WORKDIR}/xine-lib-1.2"

src_unpack() {
mercurial_src_unpack

cd "${S}" || die "cd failed"


use vdr && sed -i src/vdr/input_vdr.c -e '/define VDR_ABS_FIFO_DIR/s|".*"|"/var/vdr/xine"|'
use vdpau && epatch "${FILESDIR}/xine-lib-1.2-r11607-vdpau-extensions-v20.diff"
#epatch "${FILESDIR}/longrunninggrabfix.diff"
}

src_compile() {
./autogen.sh noconfig || die "autogen failed"

#prevent quicktime crashing
append-flags -frename-registers -ffunction-sections

# Specific workarounds for too-few-registers arch...
if [[ $(tc-arch) == "x86" ]]; then
filter-flags -fforce-addr
filter-flags -momit-leaf-frame-pointer # break on gcc 3.4/4.x
filter-flags -fno-omit-frame-pointer #breaks per bug #149704
is-flag -O? || append-flags -O2
fi

local myconf

# enable/disable appropiate optimizations on sparc
[[ "${PROFILE_ARCH}" == "sparc64" ]] && myconf="${myconf} --enable-vis"
[[ "${PROFILE_ARCH}" == "sparc" ]] && myconf="${myconf} --disable-vis"

# The default CFLAGS (-O) is the only thing working on hppa.
use hppa && unset CFLAGS

# Too many file names are the same (xine_decoder.c), change the builddir
# So that the relative path is used to identify them.
mkdir "${WORKDIR}/build"

elibtoolize
ECONF_SOURCE="${S}" econf \
$(use_enable gnome gnomevfs) \
$(use_enable nls) \
$(use_enable ipv6) \
$(use_enable samba) \
$(use_enable altivec) \
$(use_enable v4l) \
\
$(use_enable mng) \
$(use_with imagemagick) \
$(use_enable gtk gdkpixbuf) \
\
$(use_enable aac faad) \
$(use_with flac libflac) \
$(use_with vorbis) \
$(use_with speex) \
$(use_with theora) \
$(use_with wavpack) \
$(use_enable modplug) \
$(use_enable a52 a52dec) --with-external-a52dec \
$(use_enable mad) --with-external-libmad \
$(use_enable dts) --with-external-libdts \
$(use_enable musepack) --with-external-libmpcdec \
\
$(use_with X x) \
$(use_enable xinerama) \
$(use_enable vidix) \
$(use_enable dxr3) \
$(use_enable directfb) \
$(use_enable fbcon fb) \
$(use_enable opengl) \
$(use_enable aalib) \
$(use_with libcaca caca) \
$(use_with sdl) \
$(use_enable xvmc) \
$(use_with xcb) \
\
$(use_enable oss) \
$(use_enable vdpau) --enable-vdpau \
$(use_with alsa) \
$(use_with arts) \
$(use_with esd esound) \
$(use_with pulseaudio) \
$(use_with jack) \
\
$(use_enable vcd) --without-internal-vcdlibs \
\
$(use_enable win32codecs w32dll) \
$(use_enable real real-codecs) \
\
$(use_enable mmap) \
$(use_with truetype freetype) $(use_with truetype fontconfig) \
\
$(use_enable vdr) \
\
$(use_enable debug) \
--enable-asf \
--with-external-ffmpeg \
--disable-optimizations \
--disable-syncfb \
${myconf} \
--with-xv-path=/usr/$(get_libdir) \
--with-w32-path=/usr/$(ABI=x86 get_libdir)/win32 \
--with-real-codecs-path=/usr/$(get_libdir)/codecs \
--enable-fast-install \
--disable-dependency-tracking || die "econf failed."

emake || die "emake failed."
}

src_install() {
emake DESTDIR="${D}" \
docdir="/usr/share/doc/${PF}" htmldir="/usr/share/doc/${PF}/html" \
install || die "emake install failed."
}
