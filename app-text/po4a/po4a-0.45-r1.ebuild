# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/po4a/po4a-0.45-r1.ebuild,v 1.1 2014/10/15 17:54:01 axs Exp $

EAPI=5

# Needed because this package also installs to vendor_perl
GENTOO_DEPEND_ON_PERL_SUBSLOT="yes"
inherit perl-app

DESCRIPTION="Tools for helping translation of documentation"
HOMEPAGE="http://po4a.alioth.debian.org"
SRC_URI="mirror://debian/pool/main/p/po4a/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="test"

RDEPEND="dev-perl/SGMLSpm
	>=sys-devel/gettext-0.13
	app-text/openjade
	dev-libs/libxslt
	dev-perl/Locale-gettext
	dev-perl/TermReadKey
	dev-perl/Text-WrapI18N"
DEPEND="${RDEPEND}
	>=virtual/perl-Module-Build-0.380.0
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd:4.1.2
	test? ( app-text/docbook-sgml-dtd
		app-text/docbook-sgml-utils
		virtual/tex-base )"

SRC_TEST="do"
