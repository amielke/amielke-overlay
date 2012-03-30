# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

EAPI=2

inherit subversion eutils webapp depend.php

DESCRIPTION="Web-based configuration tool written to configure Nagios. Replace and update the older Lilac 1.03 is still not posible!"
HOMEPAGE="https://sourceforge.net/projects/lilac--reloaded/"

ESVN_REPO_URI="http://lilac--reloaded.svn.sourceforge.net/svnroot/lilac--reloaded/trunk"
ESVN_PROJECT="lilac-reloaded"

LICENSE="GPL-2"
KEYWORDS=""
IUSE="nmap"

RDEPEND=">=virtual/mysql-5.1
	>=net-analyzer/nagios-3.2
	>=dev-php/PEAR-PEAR-1.9.2
	dev-lang/php[curl,json,mysql,pcntl,pdo,posix,simplexml]
	nmap? ( >=net-analyzer/nmap-5.51 )"

need_php_httpd

S="${WORKDIR}"/trunk

src_unpack() {
        subversion_src_unpack
}

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
