# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit java-pkg-2

DESCRIPTION="JavaScript optimizing compiler"
HOMEPAGE="https://github.com/google/closure-compiler"
SRC_URI="https://dl.google.com/closure-compiler/compiler-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=">=virtual/jre-1.6"

S=${WORKDIR}

src_install() {
	java-pkg_jarinto /opt/${PN}-${SLOT}/lib
	java-pkg_newjar ${PN%-bin}-v${PV}.jar ${PN}.jar
	java-pkg_dolauncher \
		${PN%-bin} \
		--jar /opt/${PN}-${SLOT}/lib/${PN}.jar \
		-into /opt
	dodoc README.md
}
