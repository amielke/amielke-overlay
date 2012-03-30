# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

EAPI=2

inherit eutils webapp depend.php

DESCRIPTION="Web-based configuration tool written to configure Nagios. Replace and update the older Lilac 1.03 is still not posible!"
HOMEPAGE="https://sourceforge.net/projects/lilac--reloaded/"
SRC_URI="http://sourceforge.net/projects/lilac--reloaded/files/2.0/lilac-reloaded-2.0.tar.gz"

LICENSE="GPL-2"
## Unstable KEYWORDS="~amd64 ~x86"
KEYWORDS="amd64 ~x86"

# LiveEbuild, z.B. aus dem SVN
#KEYWORDS=""
IUSE="nmap"

RDEPEND=">=virtual/mysql-5.1
	>=net-analyzer/nagios-3.2
	>=dev-php/PEAR-PEAR-1.9.2
	dev-lang/php[curl,json,mysql,pcntl,pdo,posix,simplexml]
	nmap? ( >=net-analyzer/nmap-5.51 )"

need_php_httpd

#S="${WORKDIR}"/${P}
S="${WORKDIR}"/trunk

src_install() {
	webapp_src_preinst

	dodoc INSTALL UPGRADING
	rm -f INSTALL UPGRADING

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_configfile "${MY_HTDOCSDIR}"/includes/lilac-conf.php.dist
	webapp_serverowned "${MY_HTDOCSDIR}"/includes/lilac-conf.php.dist
	webapp_src_install
}
