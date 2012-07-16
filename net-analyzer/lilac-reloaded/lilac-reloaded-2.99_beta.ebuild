# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

EAPI=3

inherit git-2 eutils webapp depend.php

DESCRIPTION="Web-based configuration tool written to configure Nagios. Update and replace your older version of Lilac or Lilac-Reloaded! This is the Master-Version from GIT."
HOMEPAGE="https://sourceforge.net/projects/lilac--reloaded/"

EGIT_REPO_URI="git://lilac--reloaded.git.sourceforge.net/gitroot/lilac--reloaded/lilac--reloaded"
EGIT_PROJECT="lilac-reloaded"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="nmap"

RDEPEND=">=virtual/mysql-5.1
	>=net-analyzer/nagios-3.2
	>=dev-php/PEAR-PEAR-1.9.2
	dev-lang/php[curl,json,mysql,pcntl,pdo,posix,simplexml]
	nmap? ( >=net-analyzer/nmap-5.51 )"

need_php_httpd

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
