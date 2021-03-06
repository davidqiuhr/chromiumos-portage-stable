# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pixman/pixman-0.32.4.ebuild,v 1.11 2013/12/26 20:17:27 zlogene Exp $

EAPI=4
XORG_MULTILIB=yes
inherit xorg-2 toolchain-funcs versionator

EGIT_REPO_URI="git://anongit.freedesktop.org/git/pixman"
DESCRIPTION="Low-level pixel manipulation routines"

KEYWORDS="*"
IUSE="altivec iwmmxt loongson2f mmxext neon sse2 ssse3"
RDEPEND="abi_x86_32? (
	!<=app-emulation/emul-linux-x86-gtklibs-20131008
	!app-emulation/emul-linux-x86-gtklibs[-abi_x86_32(-)]
	)"

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable mmxext mmx)
		$(use_enable sse2)
		$(use_enable ssse3)
		$(use_enable altivec vmx)
		$(use_enable neon arm-neon)
		$(use_enable iwmmxt arm-iwmmxt)
		$(use_enable loongson2f loongson-mmi)
		--disable-gtk
		--disable-libpng
	)
	# Pixman can't be built with clang's integrated assembler.
	# Fallback to GNU assembler. Note that it has to be set with
	# modifying CCASFLAGS (changing CFLAGS doesn't work with pixman).
	# https://crbug.com/793487
	CCASFLAGS+=" -fno-integrated-as"
	xorg-2_src_configure
}

src_prepare() {
	epatch "${FILESDIR}"/pixman-clang.patch
}
