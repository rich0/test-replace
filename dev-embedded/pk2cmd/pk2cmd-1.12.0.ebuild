# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pk2cmd/pk2cmd-1.12.0.ebuild,v 1.1 2008/09/19 06:58:18 josejx Exp $

inherit toolchain-funcs

DESCRIPTION="An application for working with the Microchip PicKit2 PIC programmer"
HOMEPAGE="http://www.microchip.com/pickit2"
SRC_URI="http://ww1.microchip.com/downloads/en/DeviceDoc/${PN}v${PV}LinuxMacSource.tar.gz"

LICENSE="MicroChip-PK2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="dev-libs/libusb"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}v${PV}LinuxMacSource"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix up the Makefile
	sed -i 's:#TARGET=linux:TARGET=linux:' Makefile
	sed -i 's:DBG=-O2:DBG=:' Makefile
	sed -i 's:^CFLAGS=:CFLAGS+=:' Makefile
	sed -i 's:^LIBUSB=/usr/local:LIBUSB=/usr:' Makefile
	sed -i "s:^CC=g++::" Makefile
}

src_compile() {
	emake CC="$(tc-getCXX)" || die "emake failed"
}

src_install() {
	# Copy the device files and PicKit2 OS
	insinto "/usr/share/pk2"
	doins PK2DeviceFile.dat
	doins PK2V023200.hex
	# Install the program
	exeinto /usr/bin
	doexe pk2cmd
	# Install the documentation
	dodoc ReadmeForPK2CMDLinux2-6.txt usbhotplug.txt
}
