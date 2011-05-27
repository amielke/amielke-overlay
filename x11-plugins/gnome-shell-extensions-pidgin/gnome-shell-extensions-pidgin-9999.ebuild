# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="git://github.com/kagesenshi/${PN}.git
	http://github.com/kagesenshi/${PN}.git"
inherit git-2

DESCRIPTION="Pidgin GNOME3 integration extension"
HOMEPAGE="https://github.com/kagesenshi/gnome-shell-extensions-pidgin"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="gnome-base/gnome-shell
	net-im/pidgin[dbus]"

src_install() {
	local uuid=$(awk -F'[\t ":,]+' '$2 == "uuid" { print $3 }' metadata.json)

	insinto /usr/share/gnome-shell/extensions/"${uuid}"
	doins extension.js metadata.json
}
