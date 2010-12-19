# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gamess/gamess-20090112.1-r1.ebuild,v 1.10 2010/12/19 20:56:27 jlec Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="A powerful quantum chemistry package"
HOMEPAGE="http://www.msg.chem.iastate.edu/GAMESS/GAMESS.html"
SRC_URI="
		${P}.tar.gz
		qmmm-tinker? ( tinker.tar.Z )"

LICENSE="gamess"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="hardened qmmm-tinker"

DEPEND="app-shells/tcsh
	hardened? ( sys-apps/paxctl )
	virtual/blas"

RDEPEND="${DEPEND}
	net-misc/openssh"

RESTRICT="fetch"

S="${WORKDIR}/${PN}"

GAMESS_DOWNLOAD="http://www.msg.ameslab.gov/GAMESS/License_Agreement.html"
GAMESS_VERSION="12 JAN 2009 (R1)"

pkg_nofetch() {
	echo
	elog "Please download ${PN}-current.tar.gz from"
	elog "${GAMESS_DOWNLOAD}."
	elog "Be sure to select the version ${GAMESS_VERSION} tarball!!"
	elog "Then move the tarball to"
	elog "${DISTDIR}/${P}.tar.gz"
	if use qmmm-tinker ; then
		elog "Also download http://www.msg.ameslab.gov/GAMESS/tinker.tar.Z"
		elog "and place tinker.tar.Z to ${DISTDIR}"
	fi
	echo
}

pkg_setup() {

	# currently amd64 is only supported with gfortran
	if [[ "${ARCH}" == "amd64" ]] && [[ "$(tc-getFC)" != *gfortran* ]];
		then die "You will need gfortran to compile gamess on amd64"
	fi

	if use qmmm-tinker; then
		einfo "By default MM subsistem is restricted to 1000 atoms"
		einfo "if you want larger MM subsystems then you should set"
		einfo "QMMM_GAMESS_MAXMM variable to needed value in your make.conf"
		ebeep 5
	fi
}

src_unpack() {
	unpack ${A}
	mv tinker gamess/
	# apply LINUX-arch patches to gamess makesfiles
	epatch "${FILESDIR}"/${P}.gentoo.patch

	# select arch
	# NOTE: please leave lked alone; it should be good as is!!
	cd "${S}"
	local active_arch;
	if [[ "${ARCH}" == "amd64" ]]; then
		active_arch="linux64";
	else
		active_arch="linux32";
	fi
	sed -e "s:gentoo-target:${active_arch}:" \
		-i comp compall ddi/compddi \
		|| die "Failed to select proper architecure"

	# for hardened-gcc let't turn off ssp, since it breakes
	# a few routines
	if use hardened && [[ "$(tc-getFC)" =~ g77 ]]; then
		FFLAGS="${FFLAGS} -fno-stack-protector-all"
	fi

	# enable NEO
	sed -e "s:NEO=false:NEO=true:" -i compall lked || \
		die "Failed to enable NEO code"
	# enable GAMESS-qmmm
	if use qmmm-tinker; then
		sed -e "s:TINKER=false:TINKER=true:" -i compall lked || \
			die "Failed to enable TINKER code"
		if [ "x$QMMM_GAMESS_MAXMM" == "x" ]; then
			einfo "No QMMM_GAMESS_MAXMM set. Using default value = 1000"
		else
			einfo "Setting QMMM_GAMESS_MAXMM to $QMMM_GAMESS_MAXMM"
			sed -e "s:maxatm=1000:maxatm=$QMMM_GAMESS_MAXMM:g" \
			 -i tinker/sizes.i \
			 || die "Setting QMMM_GAMESS_MAXMM failed"
			sed -e "s:MAXATM=1000:MAXATM=$QMMM_GAMESS_MAXMM:g" \
			 -i source/inputb.src \
			 || die "Setting QMMM_GAMESS_MAXMM failed"
		fi
	fi
	# greate proper activate sourcefile
	cp "./tools/actvte.code" "./tools/actvte.f" || \
		die "Failed to create actvte.f"
	sed -e "s/^\*UNX/    /" -i "./tools/actvte.f" || \
		die "Failed to perform UNX substitutions in actvte.f"

	# fix GAMESS' compall script to use proper CC
	sed -e "s|\$CCOMP -c \$extraflags source/zunix.c|$(tc-getCC) -c \$extraflags source/zunix.c|" \
		-i compall || die "Failed setting up compall script"

	# insert proper FFLAGS into GAMESS' comp makefile
	# in case we're using ifc let's strip all the gcc
	# specific stuff
	if [[ "$(tc-getFC)" == "ifort" ]]; then
		sed -e "s/gentoo-OPT = '-O2'/OPT = '${FFLAGS} -quiet'/" \
			-e "s/gentoo-g77/$(tc-getFC)/" \
			-i comp || die "Failed setting up comp script"
	elif ! use x86; then
		sed -e "s/-malign-double //" \
			-e "s/gentoo-OPT = '-O2'/OPT = '${FFLAGS}'/" \
			-e "s/gentoo-g77/$(tc-getFC)/" \
			-i comp || die "Failed setting up comp script"
	else
		sed -e "s/gentoo-OPT = '-O2'/OPT = '${FFLAGS}'/" \
			-e "s/gentoo-g77/$(tc-getFC)/" \
			-i comp || die "Failed setting up comp script"
	fi

	# fix up GAMESS' linker script;
	sed -e "s/gentoo-g77/$(tc-getFC)/" \
		-e "s/gentoo-LDOPTS=' '/LDOPTS='${LDFLAGS}'/" \
		-i lked || die "Failed setting up lked script"

	# fix up GAMESS' ddi TCP/IP socket build
	sed -e "s/gentoo-CC = 'gcc'/CC = '$(tc-getCC)'/" \
		-e "s/gentoo-g77/$(tc-getFC)/" \
		-i ddi/compddi || die "Failed setting up compddi script"

	# fix up the checker scripts for gamess tests
	sed -e "s:set GMSPATH:#set GMSPATH:g" \
		-e "s:\$GMSPATH/tools/checktst:.:g" \
		-i tools/checktst/checktst
}

src_compile() {
	# build actvte
	cd "${S}"/tools
	"$(tc-getFC)" -o actvte.x actvte.f || \
		die "Failed to compile actvte.x"

	# for hardened (PAX) users and ifc we need to turn
	# MPROTECT off
	if [[ "$(tc-getFC)" == "ifort" ]] && use hardened; then
		/sbin/paxctl -PemRxS actvte.x 2> /dev/null || \
			die "paxctl failed on actvte.x"
	fi

	# build gamess
	cd "${S}"
	./compall || die "compall failed"

	# build the ddi TCP/IP socket stuff
	cd ${S}/"ddi"
	./compddi || die "compddi failed"

	# finally, link it all together
	cd "${S}"
	./lked || die "lked failed"

	# for hardened (PAX) users and ifc we need to turn
	# MPROTECT off
	if [[ "$(tc-getFC)" == "ifort" ]] && use hardened; then
		/sbin/paxctl -PemRxS ${PN}.00.x 2> /dev/null || \
			die "paxctl failed on actvte.x"
	fi
}

src_install() {
	# the executables
	dobin ${PN}.00.x ddi/ddikick.x rungms \
		|| die "Failed installing binaries"

	# the docs
	dodoc *.DOC qmnuc/*.DOC || die "Failed installing docs"

	# install ericftm
	insinto /usr/share/${PN}/ericfmt
	doins ericfmt.dat || die "Failed installing ericfmt.dat"

	# install mcpdata
	insinto /usr/share/${PN}/mcpdata
	doins mcpdata/* || die "Failed installing mcpdata"

	# install tinker params in case of qmmm
	if use qmmm-tinker ; then
			dodoc tinker/simomm.doc || die "Failed installing docs"
			insinto /usr/share/${PN}
			doins -r tinker/params || die "Failed to install Tinker params"
	fi

	# install the tests the user should run, and
	# fix up the runscript; also grab a copy of rungms
	# so the user is ready to run the tests
	insinto /usr/share/${PN}/tests
	insopts -m0644
	doins tests/* || die "Failed installing tests"
	insopts -m0744
	doins runall || die "Failed installing tests"
	doins tools/checktst/checktst tools/checktst/chkabs || \
		die "Failed to install main test checker"
	doins tools/checktst/exam* || \
		die "Failed to install individual test files"

	insinto /usr/share/${PN}/neotests
	insopts -m0644
	doins -r qmnuc/neotests/* || die "Failed to install NEO tests"
}

pkg_postinst() {
	echo
	einfo "Before you use GAMESS for any serious work you HAVE"
	einfo "to run the supplied test files located in"
	einfo "/usr/share/gamess/tests and check them thoroughly."
	einfo "Otherwise all scientific publications resulting from"
	einfo "your GAMESS runs should be immediately rejected :)"
	einfo "To do so copy the content of /usr/share/gamess/tests"
	einfo "to some temporary location and execute './runall'. "
	einfo "Then run the checktst script in the same directory to"
	einfo "validate the tests."
	einfo "Please consult TEST.DOC and the other docs!"

	if [[ "$(tc-getFC)" == "ifort" ]]; then
		echo
		ewarn "IMPORTANT NOTE: We STRONGLY recommend to stay away"
		ewarn "from ifc-9.0 for now and use the ifc-8.1 series of"
		ewarn "compilers UNLESS you can run through ALL of the "
		ewarn "test cases (see above) successfully."
	fi

	echo
	einfo "If you want to run on more than a single CPU"
	einfo "you will have to acquaint yourself with the way GAMESS"
	einfo "does multiprocessor runs and adjust rungms according to"
	einfo "your target network architecture."
	echo
}
