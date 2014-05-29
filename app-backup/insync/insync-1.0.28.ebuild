DESCRIPTION="Advanced cross-platform Google Drive client"
HOMEPAGE="https://www.insynchq.com/"
SRC_URI="
	cinnamon? (
		
http://s.insynchq.com/builds/insync-beta-cinnamon_${PV}_all.deb
		x86? ( 
http://s.insynchq.com/builds/insync-beta-gnome-cinnamon-common_${PV}_i386.deb 
)
		amd64? ( 
http://s.insynchq.com/builds/insync-beta-gnome-cinnamon-common_${PV}_amd64.deb 
)
	)
	gnome? (
		
http://s.insynchq.com/builds/insync-beta-gnome_${PV}_all.deb
		x86? ( 
http://s.insynchq.com/builds/insync-beta-gnome-cinnamon-common_${PV}_i386.deb 
)
		amd64? ( 
http://s.insynchq.com/builds/insync-beta-gnome-cinnamon-common_${PV}_amd64.deb 
)
	)
	kde? (
		http://s.insynchq.com/builds/insync.plasmoid
		http://s.insynchq.com/builds/gdrive_webview.plasmoid
		x86? ( 
http://s.insynchq.com/builds/insync-beta-kde_${PV}_i386.deb )
		amd64? ( 
http://s.insynchq.com/builds/insync-beta-kde_${PV}_amd64.deb )
	)
	mate? (
		x86? ( 
http://s.insynchq.com/builds/insync-beta-mate_${PV}_i386.deb )
		amd64? ( 
http://s.insynchq.com/builds/insync-beta-mate_${PV}_amd64.deb )
	)
	unity? (
		x86? ( 
http://s.insynchq.com/builds/insync-beta-ubuntu_${PV}_i386.deb )
		amd64? ( 
http://s.insynchq.com/builds/insync-beta-ubuntu_${PV}_amd64.deb )
	)
	xfce? (
		x86? ( 
http://s.insynchq.com/builds/insync-beta-xfce_${PV}_i386.deb )
		amd64? ( 
http://s.insynchq.com/builds/insync-beta-xfce_${PV}_amd64.deb )
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
		-- gnome-extra/cinnamon --
		-- otherwise the same as USE=gnome --
	)
	gnome? (
		-- gnome-base/gnome --
		-- maybe more --
	)
	kde? (
		-- kde-base/kdelibs --
		-- maybe more --
	)
	mate? (
		-- x11-wm/mate --
		-- maybe more --
	)
	unity? (
		-- x11-wm/unity --
		-- maybe more --
	)
	xfce? (
		-- xfce-base/xfce4-meta --
		-- maybe more --
	)
"

src_install() {
	for u in ${IUSE_DESKTOP} ; do
		if use ${u} ; then
			: # into: /opt/${PN}-${u}
		fi
	done
}

