# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 pypy )

inherit distutils-r1

MY_P="PyBluez-${PV}"

DESCRIPTION="Python bindings for Bluez Bluetooth Stack"
HOMEPAGE="https://github.com/karulis/pybluez"
SRC_URI="https://pybluez.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="examples"

DEPEND="net-wireless/bluez"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

python_install_all() {
	use examples && local EXAMPLES=( examples/. )

	distutils-r1_python_install_all
}
