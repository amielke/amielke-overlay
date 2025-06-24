# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

_PN="FreeTube"
LANGUAGES="af am ar bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he
	hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro ru sk sl sr
	sv sw ta te th tr uk ur vi zh-CN zh-TW"

for lang in ${LANGUAGES}; do
	IUSE+=" +l10n_${lang}"
done

inherit desktop xdg-utils

DESCRIPTION="An open source desktop YouTube player built with privacy in mind."
HOMEPAGE="https://github.com/${_PN}App/${_PN}"

LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
SRC_URI="amd64? ( ${HOMEPAGE}/releases/download/v${PV}-beta/${PN}_${PV}_amd64.deb -> ${P}-amd64.deb )
    arm64? ( ${HOMEPAGE}/releases/download/v${PV}-beta/${PN}_${PV}_arm64.deb -> ${P}-arm64.deb )"
BDEPEND="!!media-sound/freetube"
QA_PREBUILT="opt/${_PN}/swiftshader/libEGL.so
    opt/${_PN}/swiftshader/libGLESv2.so
    opt/${_PN}/chrome-sandbox
    opt/${_PN}/${PN}
    opt/${_PN}/libEGL.so
    opt/${_PN}/libGLESv2.so
    opt/${_PN}/libffmpeg.so
    opt/${_PN}/libvk_swiftshader.so
    opt/${_PN}/libvulkan.so"

S=${WORKDIR}

src_prepare() {
	bsdtar -x -f data.tar.xz    
    rm data.tar.xz control.tar.gz debian-binary	
	default
}

src_install() {
	declare FREETUBE_HOME=/opt/${_PN}
    
    pushd opt/${_PN}/locales > /dev/null || die
    for lang in ${LANGUAGES}; do
		if [[ ! -e ${lang}.pak ]]; then
			eqawarn "L10N warning: no .pak file for ${lang} (${lang}.pak not found)"
		fi
	done
    for pak in *.pak; do
		lang=${pak%.pak}

		if [[ ${lang} == en-US ]]; then
			continue
		fi

		if ! has ${lang} ${LANGUAGES}; then
			eqawarn "L10N warning: no ${lang} in LANGS"
			continue
		fi

		if ! use l10n_${lang}; then
			rm "${pak}" || die
		fi
	done
    popd
    
	dodir ${FREETUBE_HOME%/*}

	insinto ${FREETUBE_HOME}
		doins -r opt/${_PN}/*

	exeinto ${FREETUBE_HOME}
        exeopts -m4755
        doexe opt/${_PN}/chrome-sandbox
		
	exeinto ${FREETUBE_HOME}
        exeopts -m0755
		doexe opt/${_PN}/${PN}

	dosym ${FREETUBE_HOME}/${PN} /usr/bin/${PN} || die
	
	insinto /usr/share/doc/${P}
	gunzip usr/share/doc/${PN}/changelog.gz
	doins usr/share/doc/${PN}/changelog

    insinto /usr/share/icons/hicolor/scalable/apps
    doins usr/share/icons/hicolor/scalable/apps/${PN}.svg

    domenu "usr/share/applications/${PN}.desktop"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
