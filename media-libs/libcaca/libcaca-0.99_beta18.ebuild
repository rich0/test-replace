# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcaca/libcaca-0.99_beta18.ebuild,v 1.1 2012/04/08 08:56:25 radhermit Exp $

EAPI=4
PYTHON_DEPEND="*"
PYTHON_MODNAME="caca"

inherit autotools flag-o-matic mono multilib java-pkg-opt-2 python

MY_P=${P/_/.}

DESCRIPTION="A library that creates colored ASCII-art graphics"
HOMEPAGE="http://libcaca.zoy.org/"
SRC_URI="http://libcaca.zoy.org/files/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2 ISC LGPL-2.1 WTFPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="cxx doc imlib java mono ncurses opengl python ruby slang static-libs truetype X"

COMMON_DEPEND="imlib? ( media-libs/imlib2 )
	mono? ( dev-lang/mono )
	ncurses? ( >=sys-libs/ncurses-5.3 )
	opengl? (
		virtual/opengl
		media-libs/freeglut
		truetype? ( >=media-libs/ftgl-2.1.3_rc5 )
	)
	ruby? ( =dev-lang/ruby-1.8* )
	slang? ( >=sys-libs/slang-2 )
	X? ( x11-libs/libX11 x11-libs/libXt )"
RDEPEND="${COMMON_DEPEND}
	java? ( >=virtual/jre-1.5 )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	doc? (
		app-doc/doxygen
		virtual/latex-base
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-latexextra
		dev-tex/xcolor
	)
	java? ( >=virtual/jdk-1.5 )"

S=${WORKDIR}/${MY_P}

DOCS=( AUTHORS ChangeLog NEWS NOTES README THANKS )

src_prepare() {
	sed -i -e '/doxygen_tests = check-doxygen/d' test/Makefile.am || die #339962

	sed -i \
		-e 's:-g -O2 -fno-strength-reduce -fomit-frame-pointer::' \
		configure.ac || die

	sed -i \
		-e 's:$(JAVAC):$(JAVAC) $(JAVACFLAGS):' \
		-e 's:libcaca_java_la_CPPFLAGS =:libcaca_java_la_CPPFLAGS = -I../caca:' \
		java/Makefile.am || die

	if ! use truetype; then
		sed -i -e '/PKG_CHECK_MODULES/s:ftgl:dIsAbLe&:' configure.ac || die
	fi

	if use imlib && ! use X; then
		append-cflags -DX_DISPLAY_MISSING
	fi

	eautoreconf

	java-pkg-opt-2_src_prepare
}

src_configure() {
	if use java; then
		export JAVACFLAGS="$(java-pkg_javac-args)"
		append-cflags "$(java-pkg_get-jni-cflags)"
	fi

	use mono && export CSC=gmcs #329651
	export VARTEXFONTS="${T}/fonts" #44128

	econf \
		$(use_enable static-libs static) \
		$(use_enable slang) \
		$(use_enable ncurses) \
		$(use_enable X x11) $(use_with X x) --x-libraries=/usr/$(get_libdir) \
		$(use_enable opengl gl) \
		$(use_enable mono csharp) \
		$(use_enable python) \
		$(use_enable java) \
		$(use_enable cxx) \
		$(use_enable ruby) \
		$(use_enable imlib imlib2) \
		$(use_enable doc)
}

src_install() {
	default

	if use java; then
		java-pkg_newjar java/libjava.jar
	fi

	rm -rf "${D}"/usr/share/java
	find "${D}" -name '*.la' -delete
}
