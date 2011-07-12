EAPI=4

inherit rpm multilib

DESCRIPTION="Brother DCP-J315W LPR+cupswrapper drivers"
HOMEPAGE="http://welcome.solutions.brother.com/bsc/public_s/id/linux/en/download_prn.html#DCP-J315W"
SRC_URI="http://pub.brother.com/pub/com/bsc/linux/dlf/mfcj265wlpr-1.1.1-1.i386.rpm
		http://pub.brother.com/pub/com/bsc/linux/dlf/mfcj265wcupswrapper-1.1.1-3.i386.rpm"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="strip"

DEPEND="net-print/cups
		app-text/a2ps"
RDEPEND="${DEPEND}"

S="${WORKDIR}" # Portage will bitch about missing $S so lets pretend that we have vaild $S.

src_unpack() {
	rpm_unpack ${A}
}

src_install() {
	has_multilib_profile && ABI=x86

	dosbin "${WORKDIR}/usr/bin/brprintconf_mfcj265w"

	mkdir -p ${D}/opt/Brother || die
	cp -r ${WORKDIR}/usr/local/Brother/* ${D}/opt/Brother/ || die

	mkdir -p ${D}/usr/libexec/cups/filter || die
	( cd ${D}/usr/libexec/cups/filter/ && ln -s ../../../../opt/Brother/Printer/mfcj265w/lpd/filtermfcj265w brlpdwrappermfcj265w ) || die
	mkdir -p ${D}/usr/local || die
	( cd ${D}/usr/local && ln -s ../../opt/Brother Brother ) || die
	mkdir -p ${D}/usr/share/cups/model || die
	( cd ${D}/usr/share/cups/model && ln -s ../../../../opt/Brother/Printer/mfcj265w/cupswrapper/brmfcj265w.ppd ) || die
}

pkg_postinst () {
	ewarn "You really wanna read this."
	elog "You need to use brprintconf_mfcj265w to change printer options"
	elog "For example, you should set paper type to A4 right after instalation"
	elog "or your prints will be misaligned!"
	elog
	elog "Set A4 Paper type:"
	elog "		brprintconf_mfcj265w -pt A4"
	elog "Set 'Fast Normal' quality:"
	elog "		brprintconf_mfcj265w -reso 300x300dpi"
	elog
	elog "For more options just execute brprintconf_mfcj265w as root"
	elog "You can check current settings in:"
	elog "		/opt/Brother/Printer/mfcj265w/inf/brmfcj265wrc"
}

# TODO: Write alternative to filtermfcj265w or patch it for the security manner.
# TODO: Write something about config printer over WIFI.
