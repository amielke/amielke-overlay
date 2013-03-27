EAPI="4"
DESCRIPTION="Advanced cross-platform Google Drive client"
HOMEPAGE="https://www.insynchq.com/"
SRC_URI="
	cinnamon? (
		http://s.insynchq.com/builds/insync-beta-cinnamon_0.9.39_all.deb
		x86? ( http://s.insynchq.com/builds/insync-beta-gnome-cinnamon-common_${PV}_i386.deb )
		amd64? ( http://s.insynchq.com/builds/insync-beta-gnome-cinnamon-common_${PV}_amd64.deb )
	)
	gnome? (
		http://s.insynchq.com/builds/insync-beta-gnome_0.9.39_all.deb
		x86? ( http://s.insynchq.com/builds/insync-beta-gnome-cinnamon-common_${PV}_i386.deb )
		amd64? ( http://s.insynchq.com/builds/insync-beta-gnome-cinnamon-common_${PV}_amd64.deb )
	)
	kde? (
		http://s.insynchq.com/builds/insync.plasmoid
		http://s.insynchq.com/builds/gdrive_webview.plasmoid
		x86? ( http://s.insynchq.com/builds/insync-beta-kde_${PV}_i386.deb )
		amd64? ( http://s.insynchq.com/builds/insync-beta-kde_${PV}_amd64.deb )
	)
	mate? (
		x86? ( http://s.insynchq.com/builds/insync-beta-mate_${PV}_i386.deb )
		amd64? ( http://s.insynchq.com/builds/insync-beta-mate_${PV}_amd64.deb )
	)
	unity? (
		x86? ( http://s.insynchq.com/builds/insync-beta-ubuntu_${PV}_i386.deb )
		amd64? ( http://s.insynchq.com/builds/insync-beta-ubuntu_${PV}_amd64.deb )
	)
	xfce? (
		x86? ( http://s.insynchq.com/builds/insync-beta-xfce_${PV}_i386.deb )
		amd64? ( http://s.insynchq.com/builds/insync-beta-xfce_${PV}_amd64.deb )
	)
"

# KDE Plasmoids are GPL
LICENSE="GPL Insync-License"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE_DESKTOP="cinnamon gnome kde mate unity xfce"
IUSE="${IUSE_DESKTOP}"

RDEPEND="
	cinnamon? (
		gnome-extra/cinnamon
	)
	gnome? (
		>=gnome-base/gnome-desktop-3:3
	)
	kde? (
		kde-base/kdelibs
	)
	mate? (
		x11-wm/mate
	)
	unity? (
		x11-wm/unity
	)
	xfce? (
		xfce-base/xfce4-mete
	)
"
S=${WORKDIR}

#src_install() {
#	for u in ${IUSE_DESKTOP} ; do
#		if use ${u} ; then
#		: # into: /opt/${PN}-${u}
#		fi
#	done
#}
#src_unpack() {
#  unpack ${A}
#  unpack ./data.tar.gz
#  cd "${S}"
#   rm control.tar.gz data.tar.gz debian-binary
#}
src_unpack() {
    if [[ -n ${EPREFIX} ]] ; then
        # need to perform everything in the offset, #381937
        mkdir -p "./${EPREFIX}"
        cd "./${EPREFIX}" || die
    fi
    unpack ${A}
    unpack ./data.tar.gz
    rm -f control.tar.gz data.tar.gz debian-binary
}


src_install() {
   cp -pPR ${WORKDIR}/* "${D}"/ || die "Installation failed"
}
