# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/svgalib/svgalib-1.4.3-r3.ebuild,v 1.3 2003/02/13 12:55:56 vapier Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="A library for running svga graphics on the console"
SRC_URI="http://www.svgalib.org/${P}.tar.gz"
HOMEPAGE="http://www.svgalib.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 -ppc -sparc "

DEPEND="virtual/glibc"


src_unpack() {

	unpack ${A}
	
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {

	make OPTIMIZE="${CFLAGS}" static shared textutils lrmi utils || die
	# Build the gl stuff tpp
	make OPTIMIZE="${CFLAGS}" -C gl || die
	make OPTIMIZE="${CFLAGS}" -C gl libvgagl.so.${PV} || die

	make OPTIMIZE="${CFLAGS}" LDFLAGS='-L ../sharedlib' demoprogs || die
	
	cp Makefile Makefile.orig
	sed 's/\(install: $(INSTALLAOUTLIB) \)installheaders \(.*\)/\1\2/g' \
		Makefile.orig > Makefile
}

src_install() {

	dodir /etc/{vga,svga} /usr/{include,lib,bin,share/man}
	make TOPDIR=${D} OPTIMIZE="${CFLAGS}" install || die
	insinto /usr/include
	doins gl/vgagl.h
	dolib.a gl/libvgagl.a
	dolib.so gl/libvgagl.so.${PV}
	dosym libvgagl.so.${PV} /usr/lib/libvgagl.so
	preplib

	insinto /usr/include
	doins src/vga.h gl/vgagl.h src/mouse/vgamouse.h src/joystick/vgajoystick.h
	doins src/keyboard/vgakeyboard.h

	cd ${S}/demos
	exeinto /usr/lib/svgalib/demos
	local DEMO_PROGS="fun testgl speedtest mousetest vgatest scrolltest \
	    testlinear \
	    keytest testaccel accel forktest eventtest spin bg_test printftest \
	    joytest mjoytest bankspeed lineart linearspeed addmodetest \
	    svidtune linearfork vgatweak"
	doexe ${DEMO_PROGS}

	cd ${S}/threeDKit
	exeinto /usr/lib/svgalib/theeDKit
	local THREED_PROGS="plane wrapdemo"
	doexe ${THREED_PROGS}

	cd ${S}/doc
	dodoc 0-README CHANGES* DESIGN NEWS TODO
	docinto txt
	dodoc  Driver-programming-HOWTO README.* add_driver svgalib.lsm
}

